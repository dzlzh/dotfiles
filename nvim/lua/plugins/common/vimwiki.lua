return {
    "vimwiki/vimwiki",
    cmd = {
        "VimwikiIndex",
    },
    keys = {
        { "<Leader>ww", "<Plug>VimwikiIndex" },
    },
    init = function()
        vim.api.nvim_set_keymap('n', '<Leader>t', '<Plug>VimwikiToggleListItem', {noremap = true})
        vim.cmd([[
            hi VimwikiHeader1 guifg=#FF0000
            hi VimwikiHeader2 guifg=#00FF00
            hi VimwikiHeader3 guifg=#FF00FF
            hi VimwikiHeader4 guifg=#0000FF
            hi VimwikiHeader5 guifg=#00FFFF
            hi VimwikiHeader6 guifg=#FFFF00
        ]])
        vim.g.vimwiki_list = {{
            path = "~/.vimwiki",
            index = 'README',
            syntax = 'markdown',
            ext = '.md',
            nested_syntaxes = {
                python = 'python',
                ['c++'] = 'cpp',
                java = 'java',
                sh = 'sh',
                viml = 'vim',
                xml = 'xml',
                json = 'json',
                css = 'css',
                html = 'html',
                php = 'php',
                go = 'go',
                sql = 'sql',
                javascript = 'js'
            }
        }}
    end
}
