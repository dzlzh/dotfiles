# 使用 Git 管理系统配置文件

这段代码的作用是将名为 `dotfiles` 的项目迁移到新环境中，并在本地创建一个裸仓库来管理系统配置文件。

## 迁移

```sh
git clone --depth=1 https://github.com/dzlzh/dotfiles.git
```
首先，使用以下命令克隆 `dotfiles` 项目：

假设要迁移 `linux` 和 `i3wm` 两个分支，分别将它们克隆到 `$HOME/.dotfiles.git` 目录下，并使用 `--bare` 选项创建裸仓库。然后定义一个 `dfm` 别名，方便后续操作。

```sh
git clone -b=linux --bare --depth=1 https://github.com/dzlzh/dotfiles.git $HOME/.dotfiles.git
git clone -b=i3wm --bare --depth=1 https://github.com/dzlzh/dotfiles.git $HOME/.dotfiles.git

alias dfm="/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"

dfm checkout

mkdir -p dotfiles_backup && \
dfm checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} dotfiles_backup/{}

dfm config --local status.showUntrackedFiles no
```

以上命令将 `dotfiles` 项目的文件复制到 `$HOME` 目录下，并备份已存在的文件。
先创建一个名为 `dotfiles_backup` 的目录来存放备份文件。
可能会出现冲突，因为 `$HOME` 目录下已经存在同名文件，所以使用 `egrep` 和 `awk` 命令提取出冲突的文件名，并将它们移动到备份目录中。最后，
使用 `dfm config` 命令关闭显示未跟踪文件的提示，以便于管理系统配置文件。

## 新项目

如果想要在新项目中使用 `dotfiles`，可以按照以下步骤：

首先，在新项目的根目录下创建一个裸仓库，用于管理系统配置文件。

```sh
git init --bare $HOME/.dotfiles.git
```

然后，定义 `dfm` 别名，方便后续操作，并关闭显示未跟踪文件的提示。

```sh
alias dfm="/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
dfm config --local status.showUntrackedFiles no
```

这样就可以将系统配置文件添加到 `dotfiles` 项目中进行管理了。
