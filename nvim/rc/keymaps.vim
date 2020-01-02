" -----------------------------------------------------------------------------
"  < 快捷键映射 >
" -----------------------------------------------------------------------------
" 更新配置
nnoremap <Leader>r :so $MYVIMRC<CR>

" 系统复制/粘贴
vnoremap <Leader>y "+y
nnoremap <Leader>y "+yy
nnoremap <Leader>p "+p

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
nnoremap <silent><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 常规模式下文件格式转成 Unix
nnoremap <Leader>U :set fileformat=unix<CR>

" terminal emulation
func! OpenTerminal()
    if g:iswindows
        exec "botright split term://bash"
    else
        exec "botright split term://zsh"
    endif
    exec "resize 15"
endfunc
nnoremap <Leader>sh :call OpenTerminal()<CR>
augroup VimUnixTerminalGroup
    au!
    au TermOpen * setlocal nonumber signcolumn=no
augroup END
tnoremap <Esc> <C-\><C-n>
