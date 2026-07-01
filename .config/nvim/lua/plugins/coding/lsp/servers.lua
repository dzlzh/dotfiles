local M = {}

local registry = {
    {
        name = "lua_ls",
        mason = "lua_ls",
        config = function(opts)
            return {
                capabilities = opts.capabilities,
                on_init = function(client)
                    local path = client.workspace_folders
                        and client.workspace_folders[1]
                        and client.workspace_folders[1].name

                    if not path or (not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
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

                        client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end

                    return true
                end,
            }
        end,
    },
    {
        name = "gopls",
        mason = "gopls",
        config = function(opts)
            return {
                capabilities = opts.capabilities,
                settings = {
                    gopls = {
                        experimentalPostfixCompletions = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
                init_options = {
                    usePlaceholders = true,
                },
            }
        end,
    },
    {
        name = "intelephense",
        mason = "intelephense",
        config = function(opts)
            return {
                capabilities = opts.capabilities,
                init_options = {
                    globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",
                },
            }
        end,
    },
    {
        name = "marksman",
        mason = "marksman",
        config = function(opts)
            return {
                capabilities = opts.capabilities,
            }
        end,
    },
    {
        name = "vue_ls",
        mason = "vue_ls",
        config = function(opts)
            return {
                capabilities = opts.capabilities,
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
            }
        end,
    },
}

local function collect(field)
    local values = {}
    for _, server in ipairs(registry) do
        table.insert(values, server[field])
    end
    return values
end

function M.ensure_installed()
    return collect("mason")
end

function M.lsp_names()
    return collect("name")
end

function M.setup(opts)
    for _, server in ipairs(registry) do
        vim.lsp.config(server.name, server.config(opts))
        vim.lsp.enable(server.name)
    end
end

return M
