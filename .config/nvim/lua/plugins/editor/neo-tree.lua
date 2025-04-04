return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
        {"<Leader>ee", "<cmd>Neotree last toggle reveal<cr>", desc = "Open NeoTree"},
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    opts = {
        source_selector = {
            winbar = true,
            content_layout = "center",
            sources = {
                { source = "filesystem" },
                { source = "buffers" },
                { source = "git_status" },
            },
        },
    },
}
