return {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { remap = true, desc = "Easy Align" })
    end,
}
