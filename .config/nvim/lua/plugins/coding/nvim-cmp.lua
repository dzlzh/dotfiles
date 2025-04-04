return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind-nvim",
        "windwp/nvim-autopairs",
    },
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    config = function()
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local autopairs = require("nvim-autopairs")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        local cmpHighlight = {
            CmpNormal = { bg = "#2e3440" },
            CmpItemAbbrDeprecated = { bg = nil, strikethrough = true, fg = "#434c5e" },
            CmpItemAbbrMatch = { bg = nil, fg = "#81a1c1", bold = true },
            CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
            CmpItemKindVariable = { bg = nil, fg = "#88c0d0" },
            CmpItemKindInterface = { link = "CmpItemKindVariable" },
            CmpItemKindText = { link = "CmpItemKindVariable" },
            CmpItemKindFunction = { bg = nil, fg = "#81a1c1" },
            CmpItemKindMethod = { link = "CmpItemKindFunction" },
            CmpItemKindKeyword = { bg = nil, fg = "#800080" },
            CmpItemKindProperty = { link = "CmpItemKindKeyword" },
            CmpItemKindUnit = { link = "CmpItemKindKeyword" },
            CmpItemKindSnippet = { fg = "#d08770" },
            CmpItemKindClass = { fg = "#8fbcbb" },
            CmpItemKindEnum = { fg = "#ebcb8b" },
        }
        for group, opts in pairs(cmpHighlight) do
            vim.api.nvim_set_hl(0, group, opts)
        end

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        require("luasnip.loaders.from_vscode").lazy_load()

        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = {'string'},
                javascript = {'template_string'},
            }
        })
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        cmp.setup({
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:CmpNormal",
                    col_offset = -3,
                    side_padding = 1,
                },
                documentation = {
                    border = "rounded",
                    max_width = 50,
                    max_height = 30,
                },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip", priority = 750 },
                { name = "buffer", priority = 500 },
                { name = "path", priority = 250 },
            }),
            mapping = {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            cmp.confirm()
                        end
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ select = false }),
                }),
                ["<C-y>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                }),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "s" }),
                ["<C-f>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.scroll_docs(4)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-b>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.scroll_docs(-4)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    menu = {
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        path = "[Path]",
                    },
                }),
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = {
                ["<Tab>"] = {
                    c = function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            cmp.complete()
                        end
                    end,
                },
                ["<S-Tab>"] = {
                    c = function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            cmp.complete()
                        end
                    end,
                },
                ["<C-n>"] = {
                    c = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                },
                ["<C-p>"] = {
                    c = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                },
                ["<C-e>"] = {
                    c = cmp.mapping.abort(),
                },
                ["<C-y>"] = {
                    c = cmp.mapping.confirm({ select = false }),
                },
                ["<CR>"] = {
                    c = cmp.mapping.confirm({ select = false }),
                },
            },
            sources = cmp.config.sources({
                { name = "path" },
                { name = "cmdline" },
            }),
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
    end,
}
