" airline setting
let g:airline_theme="powerlineish"                    " 状态栏插件，更好的状态栏效果
let g:airline_powerline_fonts=1                       " 这个是安装字体后 必须设置此项

" indentLine setting
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>
let g:indentLine_char="┊"
let g:indentLine_first_char="┊"
let g:indentLine_color_term=239

" nerdtree setting
" 常规模式下输入 F2 调用插件
nmap <F2> :NERDTreeToggle<CR>

" tagbar setting
let g:tagbar_width=30                                 " 设置窗口宽度
nmap tb :TagbarToggle<CR>

" nerdcommenter setting
let NERDSpaceDelims = 1                               " 在左注释符之后，右注释符之前留有空格

" vim-easy-align setting
vmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" vimwiki setting
nmap <Leader>t :VimwikiToggleListItem<CR>
let gvimwiki_use_mouse=1
let gvimwiki_h1_headers=1
hi VimwikiHeader1 guifg=#FF0000
hi VimwikiHeader2 guifg=#00FF00
hi VimwikiHeader3 guifg=#FF00FF
hi VimwikiHeader4 guifg=#0000FF
hi VimwikiHeader5 guifg=#00FFFF
hi VimwikiHeader6 guifg=#FFFF00
let g:vimwiki_list=[{'path': g:vimwikiPath,
\ 'index': 'README',
\ 'syntax': 'markdown',
\ 'ext': '.md',
\ 'nested_syntaxes': {'python': 'python',
\ 'c++': 'cpp', 'java': 'java', 'sh': 'sh',
\ 'viml': 'vim', 'xml': 'xml', 'json': 'json',
\ 'css': 'css', 'html': 'html', 'php': 'php',
\ 'go': 'go', 'sql': 'sql', 'javascript': 'js'}}]

" AsyncRun
nmap <Leader>; :AsyncRun<space>

" vim-gitgutter
set updatetime=100

" fzf
" Open Files
map <leader>p :Files<CR>
" Open Git Files
map <leader>f :GFiles<CR>
" Open Buffers
map <leader>b :Buffers<CR>
" Open History
map <leader>h :History<CR>
" Open Ag Search 
map <A-f> :Ag<CR>
" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
" 打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
function! OpenFloatingWin()
  let height=&lines - 3
  let width=float2nr(&columns - (&columns * 2 / 10))
  let col=float2nr((&columns - width) / 2)
  " 设置浮动窗口打开的位置，大小等。
  " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
  let opts={
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }
  let buf=nvim_create_buf(v:false, v:true)
  let win=nvim_open_win(buf, v:true, opts)
  " 设置浮动窗口高亮
  call setwinvar(win, '&winhl', 'Normal:Pmenu')
  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

" Coc
" CocInstall coc-json
" CocInstall coc-phpls

" ack setting
" let g:ackprg = 'ag --nogroup --nocolor --column'
" map <A-f> :Ack<space>-i<space>

" ctrlp setting
" let g:ctrlp_map='<leader>f'
" let g:ctrlp_cmd='CtrlP'
" " \p 打开 Mru
" map <leader>p :CtrlPMRU<CR>
" " \b 打开 Buffer
" map <leader>b :CtrlPBuffer<CR>
" let g:ctrlp_custom_ignore={
"     \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
"     \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
"     \ }
" let g:ctrlp_working_path_mode=0
" let g:ctrlp_match_window_bottom=1
" let g:ctrlp_max_height=15
" let g:ctrlp_match_window_reversed=0
" let g:ctrlp_mruf_max=500
" let g:ctrlp_follow_symlinks=1

" ale setting
" let g:ale_sign_column_always = 0                      " 开启标志列
" let g:ale_sign_error='>>'                             " 自定义error图标
" let g:ale_sign_warning='--'                           " 自定义warning图标
" let g:ale_fix_on_save=1
" let g:airline#extensions#ale#enabled=1                " 在状态栏显示
" let g:ale_fixers={
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'php': ['php_cs_fixer', 'phpcbf'],
" \}
" " let g:ale_set_highlights=0
" " 文件内容发生变化时不进行检查
" " let g:ale_lint_on_text_changed='never'
" " 打开文件时不进行检查
" " let g:ale_lint_on_enter=0
" " 在vim自带的状态栏中整合ale
" " let g:ale_statusline_format=['x%d', '!%d', 'OK']
" " 显示Linter名称,出错或警告等相关信息
" " let g:ale_echo_msg_error_str='E'
" " let g:ale_echo_msg_warning_str='W'
" " let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
" " 普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
" nmap sp <Plug>(ale_previous_wrap)
" nmap sn <Plug>(ale_next_wrap)
" " <Leader>s触发/关闭语法检查
" nmap <Leader>s :ALEToggle<CR>
" " <Leader>d查看错误或警告的详细信息
" nmap <Leader>d :ALEDetail<CR>

" deoplete setting
" let g:deoplete#enable_at_startup=1
" let g:deoplete#enable_smart_case=1
" let g:deoplete#auto_complete_start_length=1
" let g:deoplete#auto_complete_delay=50

" neosnippet setting
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
" imap <expr><TAB>
"  \ pumvisible() ? "\<C-n>" :
"  \ neosnippet#expandable_or_jumpable() ?
"  \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" call remote#host#RegisterPlugin('python3', '$VIM/plugged/deoplete.nvim/rplugin/python3/deoplete.py', [
"       \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
"      \ ])
