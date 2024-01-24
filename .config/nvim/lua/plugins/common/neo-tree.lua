return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
        {"<Leader>ee", function()
            vim.cmd([[Neotree last toggle]])
        end , desc = "Open NeoTree"},
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
}
