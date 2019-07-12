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
let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeWinSize=30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" 常规模式下输入 F2 调用插件
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :NERDTreeFind<CR>

" tagbar setting
let g:tagbar_width=30                                 " 设置窗口宽度
nmap tb :TagbarToggle<CR>
let g:tagbar_type_php  = {
\ 'ctagstype' : 'php',
\ 'kinds'     : [
    \ 'i:interfaces',
    \ 'c:classes',
    \ 'd:constant definitions',
    \ 'f:functions',
    \ 'j:javascript functions:1'
\ ]
\ }

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
let g:vimwiki_list=[{'path': g:vimwiki_path,
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

" Git fugitive
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>

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
