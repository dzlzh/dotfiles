local function toggle_shell_terminal()
    require("toggleterm").toggle(1, nil, nil, "float")
end

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<Leader>sh", toggle_shell_terminal, mode = { "n", "t" }, desc = "Toggle Terminal" },
    },
    opts = {
        start_in_insert = true,
        direction = "float",
        on_open = function()
            vim.call("clearmatches")
        end,
    },
}
