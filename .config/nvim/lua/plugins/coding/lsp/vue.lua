local M = {}

function M.vue_ls()
    local tsdk = vim.fn.stdpath("data")
        .. "/mason/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"

    return {
        cmd = {
            "vue-language-server",
            "--stdio",
            "--tsdk=" .. tsdk,
        },
    }
end

function M.vtsls()
    local vue_language_server_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

    local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
        configNamespace = "typescript",
    }

    return {
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
        },
        settings = {
            vtsls = {
                tsserver = {
                    globalPlugins = {
                        vue_plugin,
                    },
                },
            },
        },
    }
end

return M
