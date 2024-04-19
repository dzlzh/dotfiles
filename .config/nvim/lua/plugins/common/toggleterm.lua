return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
        open_mapping = [[<Leader>sh]],
        start_in_insert = true,
        direction = "float",
        on_open = function ()
            vim.call("clearmatches")
        end,
    },
}
