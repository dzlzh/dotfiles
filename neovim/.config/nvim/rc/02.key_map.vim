" -----------------------------------------------------------------------------
"  < 快捷键映射 >
" -----------------------------------------------------------------------------
" 快速浏览和操作Buffer
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

"  插入模式下光标向上移动
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>

" 用反斜杠来开关折叠
nnoremap <leader>\ @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 常规模式下文件格式转成 Unix
nmap <leader>U :set fileformat=unix<CR>

" 常规模式下打开 quickfix
nmap <F3> :copen<CR>
