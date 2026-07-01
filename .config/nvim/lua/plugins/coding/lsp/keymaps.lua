local M = {}

local function goto_prev_diagnostic()
    vim.diagnostic.goto_prev({ float = false })
end

local function goto_next_diagnostic()
    vim.diagnostic.goto_next({ float = false })
end

function M.setup()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("__lsp__", { clear = true }),
        callback = function(env)
            local telescope = require("telescope.builtin")
            local opts = { buffer = env.buf, noremap = true, silent = true }

            vim.keymap.set("n", "gr", telescope.lsp_references, vim.tbl_extend("force", opts, { desc = "Check references under cursor" }))
            vim.keymap.set("n", "gd", telescope.lsp_definitions, vim.tbl_extend("force", opts, { desc = "Check definitions under cursor" }))
            vim.keymap.set("n", "gi", telescope.lsp_implementations, vim.tbl_extend("force", opts, { desc = "Check implementations under cursor" }))
            vim.keymap.set("n", "H", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Lsp Hover" }))
            vim.keymap.set("n", "ga", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
            vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
            vim.keymap.set("n", "[d", goto_prev_diagnostic, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
            vim.keymap.set("n", "]d", goto_next_diagnostic, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
        end,
    })
end

return M
