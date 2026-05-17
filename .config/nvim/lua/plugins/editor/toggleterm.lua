local codex_terminal

local function toggle_shell_terminal()
    require("toggleterm").toggle(1, nil, nil, "float")
end

local function toggle_codex_terminal()
    local Terminal = require("toggleterm.terminal").Terminal

    if not codex_terminal then
        codex_terminal = Terminal:new({
            cmd = "codex",
            count = 99,
            direction = "float",
            display_name = "Codex",
            hidden = true,
        })
    end

    codex_terminal:toggle()
end

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<Leader>sh", toggle_shell_terminal, mode = { "n", "t" }, desc = "Toggle Terminal" },
        { "<Leader>sc", toggle_codex_terminal, mode = { "n", "t" }, desc = "Toggle Codex Terminal" },
    },
    opts = {
        start_in_insert = true,
        direction = "float",
        on_open = function()
            vim.call("clearmatches")
        end,
    },
}
