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

        local group = vim.api.nvim_create_augroup("l_treesitter", { clear = true })
        local installing = {}
        local ts_foldexpr = "v:lua.vim.treesitter.foldexpr()"

        local function apply_folds(win, buf)
            if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
                return
            end

            if vim.b[buf].ts_folds then
                vim.wo[win][0].foldmethod = "expr"
                vim.wo[win][0].foldexpr = ts_foldexpr
            elseif vim.wo[win].foldexpr == ts_foldexpr then
                vim.wo[win][0].foldmethod = "indent"
                vim.wo[win][0].foldexpr = "0"
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = "*",
            callback = function(args)
                if vim.b[args.buf].large_file then
                    vim.b[args.buf].ts_folds = nil
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

                -- Fast path: an installed parser starts without scanning the
                -- parser directory on every FileType event.
                local ok, err = pcall(vim.treesitter.start, args.buf, lang)
                if not ok then
                    local available = vim.list_contains(ts.get_available(), lang)
                    local installed = vim.list_contains(ts.get_installed("parsers"), lang)

                    if not installed then
                        if not available or installing[lang] then
                            return
                        end

                        installing[lang] = true
                        vim.notify(("Installing Tree-sitter parser: %s"):format(lang), vim.log.levels.INFO)
                        -- force: nvim-treesitter's own skip check counts leftover query
                        -- directories as "installed", which would no-op the install.
                        ts.install(lang, { force = true }):await(function(install_err, install_ok)
                            installing[lang] = nil
                            vim.schedule(function()
                                if
                                    install_err
                                    or not install_ok
                                    or not vim.list_contains(ts.get_installed("parsers"), lang)
                                then
                                    vim.notify(
                                        ("Failed to install Tree-sitter parser %s: %s"):format(
                                            lang,
                                            install_err or "unknown error"
                                        ),
                                        vim.log.levels.WARN
                                    )
                                    return
                                end
                                vim.notify(("Installed Tree-sitter parser: %s"):format(lang), vim.log.levels.INFO)
                                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                                    if
                                        vim.api.nvim_buf_is_loaded(buf)
                                        and vim.treesitter.language.get_lang(vim.bo[buf].filetype) == lang
                                    then
                                        vim.api.nvim_exec_autocmds("FileType", { group = group, buffer = buf })
                                    end
                                end
                            end)
                        end)
                        return
                    end

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

                vim.b[args.buf].ts_folds = true
                for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
                    apply_folds(win, args.buf)
                end
            end,
        })

        -- Fold options are window-local and follow the window to the next
        -- buffer, so re-evaluate them whenever a buffer is shown in a window.
        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = group,
            pattern = "*",
            callback = function(args)
                apply_folds(vim.api.nvim_get_current_win(), args.buf)
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
