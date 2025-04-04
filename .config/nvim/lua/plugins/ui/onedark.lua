return {
    "navarasu/onedark.nvim",
    priority = 100,
    opts = { style = "darker" },
    init = function()
        vim.cmd([[colorscheme onedark]])
    end
}
