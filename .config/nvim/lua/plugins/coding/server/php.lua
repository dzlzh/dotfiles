local Server = {}

function Server.checkOK()
    return vim.fn.executable("intelephense") == 1
end

function Server.setup(opts)
    -- local lspconfig = opts.lspconfig
    -- lspconfig.intelephense.setup({
    --     capabilities = opts.capabilities,
    --     init_options = {
    --         globalStoragePath = vim.fn.stdpath('data') .. '/intelephense',
    --     },
    -- })
    vim.lsp.config('intelephense', {
        capabilities = opts.capabilities,
        init_options = {
            globalStoragePath = vim.fn.stdpath('data') .. '/intelephense',
        },
    })
    vim.lsp.enable('intelephense')
end

return Server
