-- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
-- source $HOME/.cargo/env
-- cargo install tree-sitter-cli
local parsers = require("treesitter_parsers")

local indent_langs = {
    bash = true,
    go = true,
    html = true,
    javascript = true,
    json = true,
    lua = true,
    markdown = true,
    php = true,
    python = true,
    query = true,
    rust = true,
    sql = true,
    toml = true,
    tsx = true,
    typescript = true,
    vue = true,
    yaml = true,
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
        local ts = require("nvim-treesitter")
        assert(ts.install(parsers, { summary = true }):wait(300000), "Tree-sitter parser installation failed")
        assert(ts.update(parsers, { summary = true }):wait(300000), "Tree-sitter parser update failed")
    end,
    config = function()
        local ok_ts, ts = pcall(require, "nvim-treesitter")
        if not ok_ts or type(ts.setup) ~= "function" then
            vim.notify("nvim-treesitter main API is not available; run :Lazy sync nvim-treesitter", vim.log.levels.WARN)
            return
        end

        ts.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        vim.treesitter.language.register("bash", { "sh" })
        vim.treesitter.language.register("ini", { "dosini", "ini" })

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("l_treesitter", { clear = true }),
            pattern = "*",
            callback = function(args)
                if vim.b[args.buf].large_file then
                    pcall(vim.treesitter.stop, args.buf)
                    if vim.bo[args.buf].indentexpr == "v:lua.require'nvim-treesitter'.indentexpr()" then
                        vim.bo[args.buf].indentexpr = ""
                    end
                    return
                end

                local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if not lang then
                    return
                end

                local available = vim.list_contains(ts.get_available(), lang)
                local installed = vim.list_contains(ts.get_installed("parsers"), lang)
                if not available and not installed then
                    return
                end

                local ok, err = pcall(vim.treesitter.start, args.buf, lang)
                if not ok then
                    vim.schedule(function()
                        local hint
                        if available then
                            hint = ("Run :TSInstall %s to install or repair the parser."):format(lang)
                        else
                            hint =
                                "Check that the custom parser is installed on runtimepath and compatible with this Neovim version."
                        end
                        vim.notify_once(
                            ("Tree-sitter failed to start %s: %s\n%s"):format(lang, err, hint),
                            vim.log.levels.WARN
                        )
                    end)
                    return
                end

                if indent_langs[lang] then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })

        vim.keymap.set({ "n", "x" }, "<A-I>", function()
            vim.treesitter.select("parent")
        end, { desc = "Start treesitter selection" })

        vim.keymap.set("x", "<A-J>", function()
            vim.treesitter.select("parent")
        end, { desc = "Increment treesitter selection" })

        vim.keymap.set("x", "<A-K>", function()
            vim.treesitter.select("child")
        end, { desc = "Decrement treesitter selection" })
    end,
}
