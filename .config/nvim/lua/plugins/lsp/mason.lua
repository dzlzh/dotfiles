return {
    -- "williamboman/mason.nvim",
    -- dependencies = {
    --     "neovim/nvim-lspconfig",
    --     "williamboman/mason-lspconfig.nvim",
    -- },
    -- cmd = "Mason",
    -- opts = {

    --     ensure_installed = {
    --         "gopls",
    --         "intelephense",
    --         "lua-language-server",
    --         "marksman",
    --     },
    -- },
    -- config = function(_, opts)
    --     require("mason").setup(opts)
    --     local mr = require("mason-registry")
    --     for _, tool in ipairs(opts.ensure_installed) do
    --         local p = mr.get_package(tool)
    --         if not p:is_installed() then
    --             p:install()
    --         end
    --     end
    -- end,
}
