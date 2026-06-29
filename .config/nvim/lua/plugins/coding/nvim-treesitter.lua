return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        -- source $HOME/.cargo/env
        -- cargo install tree-sitter-cli

        local parsers = {
            "lua", "sql", "vim", "bash",
            "go", "gomod", "gosum", "gowork",
            "php", "rust", "python",
            "json", "yaml", "toml", "ini",
            "html", "javascript", "typescript", "vue",
            "dockerfile", "markdown", "markdown_inline", "query", "regex",
        }

        local ok_ts, ts = pcall(require, "nvim-treesitter")
        if not ok_ts or type(ts.setup) ~= "function" or type(ts.install) ~= "function" then
            vim.notify("nvim-treesitter main API is not available; run :Lazy sync nvim-treesitter", vim.log.levels.WARN)
            return
        end

        ts.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        local ok_install, install_err = pcall(ts.install, parsers)
        if not ok_install then
            vim.notify("nvim-treesitter parser install failed: " .. install_err, vim.log.levels.WARN)
        end

        vim.treesitter.language.register("bash", { "sh" })
        vim.treesitter.language.register("ini", { "dosini", "ini" })

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
            typescript = true,
            vue = true,
            yaml = true,
        }

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("l_treesitter", { clear = true }),
            pattern = "*",
            callback = function(args)
                local path = vim.api.nvim_buf_get_name(args.buf)
                local stat = path ~= "" and vim.uv.fs_stat(path) or nil
                if stat and stat.size > 5 * 1024 * 1024 then
                    return
                end

                local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if not lang then
                    return
                end

                local ok = pcall(vim.treesitter.start, args.buf, lang)
                if ok and indent_langs[lang] then
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
