" ------------------------------------------------------------------------------
"  < colorschemes >
" ------------------------------------------------------------------------------
set background=dark
colorscheme gruvbox
hi Normal ctermbg=NONE guibg=NONE 

" ------------------------------------------------------------------------------
"  < airline setting >
" ------------------------------------------------------------------------------
let g:airline_theme="powerlineish"
let g:airline_powerline_fonts=1

" ------------------------------------------------------------------------------
"  < indentLine setting >
" ------------------------------------------------------------------------------
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>
let g:indentLine_char="┊"
let g:indentLine_first_char="┊"
let g:indentLine_color_term=239

" ------------------------------------------------------------------------------
"  < nerdtree setting >
" ------------------------------------------------------------------------------
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=30
let g:NERDTreeShowHidden=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :NERDTreeFind<CR>

" ------------------------------------------------------------------------------
"  < Git fugitive setting >
" ------------------------------------------------------------------------------
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>

" ------------------------------------------------------------------------------
"  < vim-gitgutter setting >
" ------------------------------------------------------------------------------
set updatetime=100

" ------------------------------------------------------------------------------
"  < LeaderF setting >
" ------------------------------------------------------------------------------
" CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
noremap <leader>h :LeaderfMru<cr>

" ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
noremap <A-t> :LeaderfFunction!<cr>

" 最大历史文件保存 2048 个
let g:Lf_MruMaxFiles = 2048

" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件 / 目录
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30

" 显示绝对路径
let g:Lf_ShowRelativePath = 0

" 模糊匹配忽略扩展名
let g:Lf_WildIgnore = {
\ 'dir': ['.svn','.git','.hg'],
\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
\ }

" ------------------------------------------------------------------------------
"  < Ack setting >
" ------------------------------------------------------------------------------
let g:ackprg = 'ag --nogroup --nocolor --column'
map <A-f> :Ack<space>

" ------------------------------------------------------------------------------
"  < vim-session setting >
" ------------------------------------------------------------------------------
let g:session_directory=g:config . 'session'
let g:session_autoload="no"
let g:session_autosave="no"
let g:session_command_aliases=1
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" ------------------------------------------------------------------------------
"  < nerdcommenter setting >
" ------------------------------------------------------------------------------
" 在左注释符之后，右注释符之前留有空格
let NERDSpaceDelims = 1

" ------------------------------------------------------------------------------
"  < vim-easy-align setting >
" ------------------------------------------------------------------------------
vmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------------------------
"  < AsyncRun setting >
" ------------------------------------------------------------------------------
nmap <Leader>; :AsyncRun<space>

" ------------------------------------------------------------------------------
"  < tags setting >
" ------------------------------------------------------------------------------
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 禁用gutentags_plus默认键盘映射
let g:gutentags_plus_nomap = 1

" ------------------------------------------------------------------------------
"  < Coc setting >
" ------------------------------------------------------------------------------
" CocInstall coc-json
" CocInstall coc-phpls

" ------------------------------------------------------------------------------
"  < vimwiki setting >
" ------------------------------------------------------------------------------
if exists("g:vimwiki_path")
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
endif
