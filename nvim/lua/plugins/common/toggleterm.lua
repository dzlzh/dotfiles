return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<Leader>sh", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    opts = {
        open_mapping = [[<Leader>sh]],
        start_in_insert = true,
        direction = "float",
        on_open = function ()
            vim.call("clearmatches")
        end,
    },
}
