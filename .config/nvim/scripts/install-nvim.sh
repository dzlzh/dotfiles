#!/usr/bin/env bash
# GNU/Linux x86_64 / ARM64。以 root 执行 bash scripts/install-nvim.sh，后续升级使用同一命令。
# 依赖 curl、jq、tar、gzip、sed 和 GNU coreutils。旧入口和安装目录保留为 .~N~ 编号备份。
# 安装后运行 readlink -f "$(command -v nvim)"，应输出 /opt/nvim/bin/nvim。
set -euo pipefail
umask 022

case "$(uname -s)/$(uname -m)" in
    Linux/x86_64) asset=nvim-linux-x86_64.tar.gz ;;
    Linux/aarch64|Linux/arm64) asset=nvim-linux-arm64.tar.gz ;;
    *) echo 'Expected GNU/Linux on x86_64 or ARM64' >&2; exit 1 ;;
esac

dest=/opt/nvim
entry=/usr/local/bin/nvim
mkdir -p /opt /usr/local/bin
tmp=$(mktemp -d /opt/.nvim-install.XXXXXXXX)
trap 'rm -rf -- "$tmp"' EXIT

curl -fsSL --retry 3 https://api.github.com/repos/neovim/neovim/releases/latest -o "$tmp/release.json"
version=$(jq -er '.tag_name' "$tmp/release.json")

check_install() {
    local dir=$1 runtime
    [[ -x "$dir/bin/nvim" && -f "$dir/share/nvim/runtime/doc/help.txt" ]] || return 1
    [[ "$("$dir/bin/nvim" --version | sed -n '1p')" == "NVIM $version" ]] || return 1
    runtime=$(env -u VIM -u VIMRUNTIME "$dir/bin/nvim" --headless -u NONE -i NONE -n \
        '+lua io.write(vim.env.VIMRUNTIME)' +qa) || return 1
    [[ "$runtime" -ef "$dir/share/nvim/runtime" ]]
}

if [[ -L "$dest" ]] || ! check_install "$dest"; then
    sha=$(jq -er --arg name "$asset" '
        .assets[] | select(.name == $name) | .digest
        | select(startswith("sha256:")) | ltrimstr("sha256:")
    ' "$tmp/release.json")
    curl -fL --retry 3 "https://github.com/neovim/neovim/releases/download/$version/$asset" -o "$tmp/$asset"
    printf '%s  %s\n' "$sha" "$tmp/$asset" | sha256sum -c -
    mkdir "$tmp/new"
    tar -xzf "$tmp/$asset" --no-same-owner --strip-components=1 -C "$tmp/new"
    check_install "$tmp/new" || { echo 'Neovim version or runtime check failed' >&2; exit 1; }
    mv -Tv --backup=numbered -- "$tmp/new" "$dest"
fi

if [[ ! -L "$entry" || "$(readlink "$entry")" != "$dest/bin/nvim" ]]; then
    ln -sfnTv --backup=numbered -- "$dest/bin/nvim" "$entry"
fi
printf 'Neovim %s: %s\n' "$version" "$(readlink -f "$entry")"
