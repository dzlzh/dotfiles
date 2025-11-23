-- return {
--     "navarasu/onedark.nvim",
--     priority = 100,
--     opts = { style = "darker" },
--     init = function()
--         vim.cmd([[colorscheme onedark]])
--     end
-- }

-- return {
--     "ellisonleao/gruvbox.nvim",
--     priority = 1000 ,
--     config = true,
--     init = function()
--         vim.o.background = "dark"
--         vim.cmd([[colorscheme gruvbox]])
--     end
-- }

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    init = function()
        -- vim.cmd([[colorscheme catppuccin-latte ]])
        -- vim.cmd([[colorscheme catppuccin-frappe ]])
        -- vim.cmd([[colorscheme catppuccin-macchiato]])
        vim.cmd([[colorscheme catppuccin-mocha ]])
    end
}
