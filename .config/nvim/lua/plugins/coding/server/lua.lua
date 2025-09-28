local Server = {}

function Server.checkOK()
    return vim.fn.executable("lua-language-server") == 1
end

function Server.setup(opts)
    -- local lspconfig = opts.lspconfig
    -- lspconfig.lua_ls.setup({
    --     on_init = function(client)
    --         local path = client.workspace_folders[1].name
    --         if not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc") then
    --             client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
    --                 Lua = {
    --                     runtime = {
    --                         version = "LuaJIT",
    --                     },
    --                     workspace = {
    --                         checkThirdParty = false,
    --                         library = { vim.env.VIMRUNTIME },
    --                     },
    --                     diagnostics = {
    --                         globals = { "vim" },
    --                     },
    --                     hint = {
    --                         enable = true,
    --                     },
    --                 }
    --             })

    --             client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    --         end
    --         return true
    --     end,
    --     capabilities = opts.capabilities,
    -- })
    vim.lsp.config('lua_ls', {
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        hint = {
                            enable = true,
                        },
                    }
                })
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
            return true
        end,
        capabilities = opts.capabilities,
    })
    vim.lsp.enable('lua_ls')
end

return Server
