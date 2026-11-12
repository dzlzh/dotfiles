local function has_words_before()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col = cursor[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

-- vim.snippet cannot parse a placeholder whose default mixes text with other
-- tabstops, e.g. `${3:=> \$${4:value}}` (friendly-snippets PHP `foreach`,
-- `fun`, `class`, ...). Keep the outermost placeholder and reduce everything
-- nested inside it to plain default text.
local function flatten_nested_placeholders(snippet)
    local out = {}
    local stack = {}
    local i = 1
    local len = #snippet

    while i <= len do
        local char = snippet:sub(i, i)
        local nested = #stack > 0

        if char == "\\" then
            out[#out + 1] = snippet:sub(i, i + 1)
            i = i + 2
        elseif char == "$" then
            local rest = snippet:sub(i)
            local placeholder = rest:match("^%${%d+:")
            local braced_tabstop = rest:match("^%${%d+}")
            local bare_tabstop = rest:match("^%$%d+")

            if placeholder then
                stack[#stack + 1] = not nested
                if not nested then
                    out[#out + 1] = placeholder
                end
                i = i + #placeholder
            elseif nested and (braced_tabstop or bare_tabstop) then
                i = i + #(braced_tabstop or bare_tabstop)
            elseif rest:sub(2, 2) == "{" then
                stack[#stack + 1] = true
                out[#out + 1] = "${"
                i = i + 2
            else
                out[#out + 1] = char
                i = i + 1
            end
        elseif char == "}" and nested then
            if table.remove(stack) then
                out[#out + 1] = char
            end
            i = i + 1
        else
            out[#out + 1] = char
            i = i + 1
        end
    end

    return table.concat(out)
end

local function expand_snippet(snippet)
    if pcall(vim.snippet.expand, snippet) then
        return
    end
    vim.snippet.expand(flatten_nested_placeholders(snippet))
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
        signature = { enabled = true },
        snippets = { expand = expand_snippet },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        cmdline = { keymap = { preset = "cmdline" } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
