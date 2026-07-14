return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            if vim.b[bufnr].large_file then
                return false
            end
        end,
    },
}
