local Server = {}

function Server.checkOK()
    return vim.fn.executable("volar") == 1
end

function Server.setup(opts)
    local lspconfig = opts.lspconfig

    lspconfig.volar.setup({
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
            vue = {
                hybridMode = false,
            },
        },
        capabilities = opts.capabilities,
    })
end

return Server
