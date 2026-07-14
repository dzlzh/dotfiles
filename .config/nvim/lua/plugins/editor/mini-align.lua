return {
    "nvim-mini/mini.align",
    version = "^0.18.0",
    keys = {
        { "ga", mode = "x", desc = "Align selection" },
        { "gA", mode = "x", desc = "Align selection with preview" },
    },
    config = function()
        require("mini.align").setup()

        pcall(vim.keymap.del, "n", "ga")
        pcall(vim.keymap.del, "n", "gA")
    end,
}
