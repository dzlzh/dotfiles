local Server = {}

function Server.checkOK()
    return vim.fn.executable("intelephense") == 1
end

function Server.setup(opts)
    local lspconfig = opts.lspconfig
    lspconfig.intelephense.setup({
        capabilities = opts.capabilities,
        init_options = {
            globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense',
        },
    })
end

return Server
