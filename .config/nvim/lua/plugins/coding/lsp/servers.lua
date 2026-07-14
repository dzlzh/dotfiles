local M = {}
local vue = require("plugins.coding.lsp.vue")

local server_order = {
    "lua_ls",
    "gopls",
    "intelephense",
    "marksman",
    "vue_ls",
    "vtsls",
}

local configs = {
    lua_ls = {
        on_init = function(client)
            local path = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name

            if path and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
                return true
            end

            client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
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
                },
            })

            client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            return true
        end,
    },
    gopls = {
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
    },
    intelephense = {
        init_options = {
            globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",
        },
    },
    marksman = {},
    vue_ls = vue.vue_ls(),
    vtsls = vue.vtsls(),
}

function M.names()
    return vim.deepcopy(server_order)
end

function M.setup(opts)
    vim.lsp.config("*", {
        capabilities = opts.capabilities,
    })

    for _, name in ipairs(server_order) do
        vim.lsp.config(name, configs[name])
    end
end

return M
