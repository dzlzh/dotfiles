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
        local signs = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN]  = "󰀪 ",
            [vim.diagnostic.severity.HINT]  = "󰌶 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

        vim.diagnostic.config({
            signs = { text = signs },
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
            return bufnr, winnr
        end
        require("lspconfig.ui.windows").default_options.border = "rounded"

        local telescope = require("telescope.builtin")
        local actions_preview = require("actions-preview")
        local function goto_prev_diagnostic()
            vim.diagnostic.goto_prev({ float = false })
        end
        local function goto_next_diagnostic()
            vim.diagnostic.goto_next({ float = false })
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("__lsp__", { clear = true }),
            callback = function(env)
                local buffer = env.buf
                local opts = { buffer = buffer, noremap = true, silent = true }
                vim.keymap.set("n", "gr", telescope.lsp_references, vim.tbl_extend("force", opts, { desc = "Check references under cursor"}))
                vim.keymap.set("n", "gd", telescope.lsp_definitions, vim.tbl_extend("force", opts, { desc = "Check definitions under cursor"}))
                vim.keymap.set("n", "gi", telescope.lsp_implementations, vim.tbl_extend("force", opts, { desc = "Check implementations under cursor"}))
                vim.keymap.set("n", "H", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Lsp Hover"}))
                vim.keymap.set("n", "ga", actions_preview.code_actions, vim.tbl_extend("force", opts, { desc = "Code Actions"}))
                vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename"}))
                vim.keymap.set("n", "[d", goto_prev_diagnostic, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic"}))
                vim.keymap.set("n", "]d", goto_next_diagnostic, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
            end,
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
        local lspOpts = {capabilities = capabilities, lspconfig = lspconfig,}
        local servers = {
            "go",
            "php",
            "lua",
            "markdown",
            "vue",
        }
        for _, server in ipairs(servers) do
            local ok, serverModule = pcall(require, "plugins.lsp.server." .. server)
            if ok and serverModule.checkOK and serverModule.checkOK() then
                serverModule.setup(lspOpts)
            elseif not os.getenv("NVIM_NOT_NOTIFY_LSP_ERROR") then
                vim.notify("The lsp server " .. server .. " not found", vim.log.levels.WARN)
            end
        end

        require("formatter").setup({
            filetype = {
                go = {
                    require("formatter.filetypes.go").gofumpt,
                    require("formatter.filetypes.go").goimports,
                },
                -- php = {
                --     require("formatter.filetypes.php").pint,
                -- },
            },
        })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup("__formatter__", { clear = true }),
            command = ":FormatWrite",
        })
    end,
}
