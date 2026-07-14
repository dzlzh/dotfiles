local M = {}

local function map_opts(bufnr, desc, extra)
    return vim.tbl_extend("force", {
        buf = bufnr,
        silent = true,
        desc = desc,
    }, extra or {})
end

function M.setup()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("l_lsp", { clear = true }),
        callback = function(env)
            if vim.b[env.buf].large_file then
                local client_id = env.data and env.data.client_id
                if client_id then
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(env.buf) then
                            pcall(vim.lsp.buf_detach_client, env.buf, client_id)
                        end
                    end)
                end
                return
            end

            local telescope = require("telescope.builtin")
            vim.keymap.set(
                "n",
                "gr",
                telescope.lsp_references,
                map_opts(env.buf, "References under cursor", { nowait = true })
            )
            vim.keymap.set("n", "gd", telescope.lsp_definitions, map_opts(env.buf, "Definitions under cursor"))
            vim.keymap.set("n", "gi", telescope.lsp_implementations, map_opts(env.buf, "Implementations under cursor"))
            vim.keymap.set("n", "H", vim.lsp.buf.hover, map_opts(env.buf, "LSP hover"))
            vim.keymap.set("n", "ga", vim.lsp.buf.code_action, map_opts(env.buf, "Code actions", { nowait = true }))
            vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, map_opts(env.buf, "Rename symbol"))
        end,
    })
end

return M
