" -----------------------------------------------------------------------------
"  < 快捷键映射 >
" -----------------------------------------------------------------------------
" 快速浏览和操作Buffer
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" 设置切换Buffer快捷键
nnoremap <C-tab> :bn<CR>
nnoremap <C-s-tab> :bp<CR>

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
nmap <leader>q :call QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" terminal emulation
if g:iswindows
    nnoremap <leader>sh :vsplit term://bash<CR>
endif
tnoremap <Esc> <C-\><C-n>
