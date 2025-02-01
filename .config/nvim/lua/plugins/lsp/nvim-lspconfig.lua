return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "aznhe21/actions-preview.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "mhartington/formatter.nvim",
    },
    config = function()
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = signs.Error,
                    [vim.diagnostic.severity.WARN]  = signs.Warn,
                    [vim.diagnostic.severity.HINT]  = signs.Hint,
                    [vim.diagnostic.severity.INFO]  = signs.Info,
                },
            },
            virtual_text = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        local lspUtilOpenFloatingPreview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or "rounded"
            local bufnr, winnr = lspUtilOpenFloatingPreview(contents, syntax, opts, ...)
            if bufnr then
                vim.api.nvim_win_set_option(winnr, "winblend", 20)
            end
        end

        require("lspconfig.ui.windows").default_options.border = "rounded"

        local telescope = require("telescope.builtin")
        local actions_preview = require("actions-preview")
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("__lsp__", { clear = true }),
            callback = function(env)
                local buffer = env.buf
                vim.api.nvim_buf_set_keymap(buffer, "n", "gr", "", {
                    desc = "Check references under cursor",
                    callback = telescope.lsp_references,
                    noremap = true,
                    silent = true,})
                vim.api.nvim_buf_set_keymap(buffer, "n", "gd", "", {
                    desc = "Check definitions under cursor",
                    callback = telescope.lsp_definitions,
                    noremap = true,
                    silent = true,})
                vim.api.nvim_buf_set_keymap(buffer, "n", "gi", "", {
                    desc = "Check implementations under cursor",
                    callback = telescope.lsp_implementations,
                    noremap = true, silent = true,})
                vim.api.nvim_buf_set_keymap(buffer, "n", "H", "", {
                    desc = "Lsp Hover",
                    callback = vim.lsp.buf.hover,
                    noremap = true,
                    silent = true,})
                vim.api.nvim_buf_set_keymap(buffer, "n", "ga", "", {
                    desc = "Code Actions",
                    callback = actions_preview.code_actions,
                    noremap = true,
                    silent = true,})
                vim.api.nvim_buf_set_keymap(buffer, "n", "<Leader>r", "", {
                    desc = "Rename",
                    callback = vim.lsp.buf.rename,
                    noremap = true,
                    silent = true,})
                vim.api.nvim_buf_set_keymap(buffer, "n", "[d", "", {
                    desc = "Previous Diagnostic",
                    callback = function()
                        vim.diagnostic.goto_prev({ float = false })
                    end,
                    noremap = true,
                    silent = true,})
                vim.api.nvim_buf_set_keymap(buffer, "n", "]d", "", {
                    desc = "Next Diagnostic",
                    callback = function()
                        vim.diagnostic.goto_next({ float = false })
                    end,
                    noremap = true,
                    silent = true,})
            end,
        })

        require("formatter").setup({
            filetype = {
                go = {
                    require("formatter.filetypes.go").gofumpt,
                    require("formatter.filetypes.go").goimports,
                },
                php = {
                    require("formatter.filetypes.php").pint,
                },
            },
        })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup("__formatter__", { clear = true }),
            command = ":FormatWrite",
        })


        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "gopls",
                "intelephense",
                "lua_ls",
                "marksman",
                "volar",
            },
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        local lspconfig = require("lspconfig")
        local lspOpts = {
            capabilities = capabilities,
            lspconfig = lspconfig,
        }
        local servers = {
            "go",
            "php",
            "vue",
            "lua",
            "markdown",
        }
        for _, server in ipairs(servers) do
            local serverModule = require("plugins.lsp.server." .. server)
            if serverModule and serverModule.checkOK() then
                serverModule.setup(lspOpts)
            else
                if not os.getenv("NVIM_NOT_NOTIFY_LSP_ERROR") then
                    vim.notify("The lsp server " .. server .. " not found", vim.log.levels.WARN)
                end
            end
        end
    end,
}
