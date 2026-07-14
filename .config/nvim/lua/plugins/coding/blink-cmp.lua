local function has_words_before()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col = cursor[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

return {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        keymap = {
            preset = "none",
            ["<Tab>"] = {
                function(cmp)
                    if cmp.get_selected_item() then
                        return cmp.accept()
                    end
                    return cmp.select_next()
                end,
                "snippet_forward",
                function(cmp)
                    if has_words_before() then
                        return cmp.show()
                    end
                end,
                "fallback",
            },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<CR>"] = {
                function(cmp)
                    if cmp.get_selected_item() then
                        return cmp.accept()
                    end
                end,
                "fallback",
            },
            ["<C-y>"] = { "select_and_accept", "fallback" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },
            ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<C-Space>"] = { "show" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        },
        appearance = { nerd_font_variant = "mono" },
        completion = {
            list = { selection = { preselect = false, auto_insert = false } },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            ghost_text = { enabled = false },
        },
        signature = { enabled = false },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        cmdline = { keymap = { preset = "cmdline" } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
