return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        -- accept_suggestion = "<Tab>",
        -- clear_suggestion = "<C-]>",
        -- accept_word = "<C-j>",
        accept_suggestion = "<M-g>",
        clear_suggestion = "<M-]>",
        accept_word = "<M-j>",
      },
      ignore_filetypes = { "markdown", "text" },
      -- color = { suggestion_color = "#888888" },
      disable_inline_completion = false,
    })
  end,
}
