" -----------------------------------------------------------------------------
"  < 快捷键映射 >
" -----------------------------------------------------------------------------
" Y 复制到系统
noremap Y "+y

" 快速浏览和操作Buffer
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

"  插入模式下光标向上移动
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>

"设置切换Buffer快捷键
nnoremap <c-n> :bn<CR>
nnoremap <c-p> :bp<CR>

" 用反斜杠来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 常规模式下文件格式转成 Unix
nnoremap <leader>U :set fileformat=unix<CR>

" 常规模式下打开 quickfix
nnoremap <leader>q :call asyncrun#quickfix_toggle(6)<cr>

" terminal emulation
if g:iswindows
    nnoremap <leader>sh :vsplit term://bash<CR>
else
    nnoremap <leader>sh :vsplit term://zsh<CR>
endif
augroup VimUnixTerminalGroup
    au!
    autocmd TermOpen * setlocal nonumber signcolumn=no
augroup END
tnoremap <Esc> <C-\><C-n>

" 更新配置
nnoremap <leader>r :so $MYVIMRC<CR>

" 保存时自动删除行尾空格
func! DeleteTrailingWS()
    exec "normal mz"
    %s/\s\+$//ge
    exec "normal `z"
endfunc
noremap <leader>W :call DeleteTrailingWS()<CR>
au BufWrite * :call DeleteTrailingWS()
