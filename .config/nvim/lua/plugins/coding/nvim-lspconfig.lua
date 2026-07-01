return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("plugins.coding.lsp.diagnostics").setup()
        require("plugins.coding.lsp.keymaps").setup()

        local servers = require("plugins.coding.lsp.servers")

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = servers.ensure_installed(),
            automatic_enable = false,
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        servers.setup({ capabilities = capabilities })
    end,
}
