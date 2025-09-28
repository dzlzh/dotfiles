local Server = {}

function Server.checkOK()
    return vim.fn.executable("vue-language-server") == 1
end

function Server.setup(opts)
    -- local lspconfig = opts.lspconfig
    -- lspconfig.volar.setup({
    --     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    --     init_options = {
    --         vue = {
    --             hybridMode = false,
    --         },
    --     },
    --     capabilities = opts.capabilities,
    -- })
    vim.lsp.config('vue_ls', {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
            vue = {
                hybridMode = false,
            },
        },
        capabilities = opts.capabilities,
    })
    vim.lsp.enable('vue_ls')
end

return Server
