return {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
    config = function()
        vim.api.nvim_set_keymap('v', 'ga', '<Plug>(EasyAlign)', {})
        vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
    end,
}
