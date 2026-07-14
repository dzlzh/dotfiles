return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        "saghen/blink.cmp",
        {
            "mason-org/mason.nvim",
            opts = {},
        },
        "mason-org/mason-lspconfig.nvim",
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            lazy = false,
            cmd = {
                "MasonToolsInstall",
                "MasonToolsInstallSync",
                "MasonToolsUpdate",
                "MasonToolsUpdateSync",
            },
            dependencies = { "mason-org/mason.nvim" },
            opts = {
                ensure_installed = {
                    "stylua",
                    "goimports",
                    "gofumpt",
                },
                auto_update = false,
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 24,
                integrations = {
                    ["mason-lspconfig"] = false,
                },
            },
        },
    },
    config = function()
        require("plugins.coding.lsp.diagnostics").setup()
        require("plugins.coding.lsp.keymaps").setup()

        local servers = require("plugins.coding.lsp.servers")
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        servers.setup({ capabilities = capabilities })

        local names = servers.names()
        local automatic_enable = vim.tbl_filter(function(name)
            return name ~= "vue_ls"
        end, names)
        require("mason-lspconfig").setup({
            ensure_installed = names,
            automatic_enable = automatic_enable,
        })
        require("plugins.coding.lsp.vue_install_gate").setup()
    end,
}
