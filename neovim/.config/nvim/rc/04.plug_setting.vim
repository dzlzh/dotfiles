" airline setting
let g:airline_theme="powerlineish"                    " 状态栏插件，更好的状态栏效果
let g:airline_powerline_fonts = 1                     " 这个是安装字体后 必须设置此项
" 设置切换Buffer快捷键
nnoremap <C-tab> :bn<CR>
nnoremap <C-s-tab> :bp<CR>

" indentLine setting
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>
let g:indentLine_char = "┊"
let g:indentLine_first_char = "┊"
let g:indentLine_color_term = 239

" nerdtree setting
" 常规模式下输入 F2 调用插件
nmap <F2> :NERDTreeToggle<CR>

" ctrlp setting
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
" \p 打开 Mru
map <leader>p :CtrlPMRU<CR>
" \b 打开 Buffer
map <leader>b :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" ack setting
let g:ackprg = 'ag --nogroup --nocolor --column'
map <A-f> :Ack<space>-i<space>

" tagbar setting
let g:tagbar_width=30                                 " 设置窗口宽度
nmap tb :TagbarToggle<CR>

" nerdcommenter setting
let NERDSpaceDelims = 1                               " 在左注释符之后，右注释符之前留有空格

" vim-easy-align setting
vmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ale setting
let g:ale_sign_column_always = 0                      " 开启标志列
let g:ale_sign_error = '>>'                           " 自定义error图标
let g:ale_sign_warning = '--'                         " 自定义warning图标
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1              " 在状态栏显示
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'php': ['php_cs_fixer', 'phpcbf'],
\}
" let g:ale_set_highlights = 0
" let g:ale_lint_on_text_changed = 'never'              " 文件内容发生变化时不进行检查
" let g:ale_lint_on_enter = 0                           " 打开文件时不进行检查
" " 在vim自带的状态栏中整合ale
" let g:ale_statusline_format = ['x%d', '!%d', 'OK']
" " 显示Linter名称,出错或警告等相关信息
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" 普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
" <Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
" <Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>

" deoplete setting
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#auto_complete_delay = 50

" neosnippet setting
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
call remote#host#RegisterPlugin('python3', '$VIM/plugged/deoplete.nvim/rplugin/python3/deoplete.py', [
      \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
     \ ])

" vimwiki setting
nmap <Leader>t :VimwikiToggleListItem<CR>
let gvimwiki_use_mouse = 1
let gvimwiki_h1_headers = 1
hi VimwikiHeader1 guifg=#FF0000
hi VimwikiHeader2 guifg=#00FF00
hi VimwikiHeader3 guifg=#FF00FF
hi VimwikiHeader4 guifg=#0000FF
hi VimwikiHeader5 guifg=#00FFFF
hi VimwikiHeader6 guifg=#FFFF00
let g:vimwiki_list = [{'path': g:vimwikiPath,
\ 'index': 'README',
\ 'syntax': 'markdown',
\ 'ext': '.md',
\ 'nested_syntaxes': {'python': 'python',
\ 'c++': 'cpp', 'java': 'java', 'sh': 'sh',
\ 'viml': 'vim', 'xml': 'xml', 'json': 'json',
\ 'css': 'css', 'html': 'html', 'php': 'php',
\ 'go': 'go', 'sql': 'sql', 'javascript': 'js'}}]

" AsyncRun
nmap <Leader>: :AsyncRun<space>

" vim-gitgutter
set updatetime=100
