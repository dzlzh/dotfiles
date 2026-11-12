local function open_codex()
    require("sidekick.cli").show({ name = "codex" })
end

local function toggle_codex()
    require("sidekick.cli").toggle({ name = "codex", focus = true })
end

local function send_to_codex(opts)
    require("sidekick.cli").send(vim.tbl_extend("force", {
        name = "codex",
    }, opts))
end

return {
    "folke/sidekick.nvim",
    version = "^2.0.0",
    keys = {
        { "<Leader>sc", open_codex, mode = "n", desc = "Start/Attach Codex CLI" },
        -- Terminal mode must not map the printable leader (";").
        { "<M-a>", toggle_codex, mode = { "n", "t" }, desc = "Toggle Codex CLI" },
        {
            "<Leader>sf",
            function()
                send_to_codex({ msg = "{file}" })
            end,
            desc = "Send file to Codex",
        },
        {
            "<Leader>sv",
            function()
                send_to_codex({ msg = "{selection}" })
            end,
            mode = "x",
            desc = "Send selection to Codex",
        },
        {
            "<Leader>sd",
            function()
                send_to_codex({ prompt = "diagnostics" })
            end,
            desc = "Send diagnostics to Codex",
        },
    },
    opts = {
        nes = {
            enabled = false,
        },
        copilot = {
            status = {
                enabled = false,
            },
        },
        cli = {
            picker = "snacks",
            watch = true,
            win = {
                layout = "float",
                float = {
                    width = 0.9,
                    height = 0.9,
                    border = "rounded",
                },
            },
            mux = {
                enabled = true,
                backend = "tmux",
                create = "split",
                split = {
                    vertical = true,
                    size = 0.5,
                },
            },
        },
    },
}
