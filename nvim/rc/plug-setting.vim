" ------------------------------------------------------------------------------
"  < colorschemes >
" ------------------------------------------------------------------------------
" set background=dark

" colorscheme gruvbox

" let g:equinusocio_material_style='darker'
" let g:equinusocio_material_vertsplit='visible'
" let g:lightline = {
"     \ 'colorscheme': 'equinusocio_material',
"     \ }
" colorscheme equinusocio_material

let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1
let g:onedark_termcolors       = 256
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
colorscheme onedark

hi Normal ctermbg=NONE guibg=NONE

" ------------------------------------------------------------------------------
"  < airline setting >
" ------------------------------------------------------------------------------
let g:airline_theme="onedark"
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" ------------------------------------------------------------------------------
"  < indentLine setting >
" ------------------------------------------------------------------------------
" 开启/关闭对齐线
nmap <Leader>il :IndentLinesToggle<CR>
let g:indentLine_char="┊"
let g:indentLine_first_char="┊"
let g:indentLine_color_term=239

" ------------------------------------------------------------------------------
"  < nerdtree setting >
" ------------------------------------------------------------------------------
" let g:NERDTreeMinimalUI=1
" let g:NERDTreeDirArrows=1
" let g:NERDTreeHijackNetrw=0
" let g:NERDTreeChDirMode=2
" let g:NERDTreeShowBookmarks=1
" let g:NERDTreeWinSize=30
" let g:NERDTreeShowHidden=1
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" nmap <Leader>ee :NERDTreeToggle<CR>
" nmap <Leader>ef :NERDTreeFind<CR>

" ------------------------------------------------------------------------------
"  < nerdtree-git-plugin setting >
" ------------------------------------------------------------------------------
" let g:NERDTreeIndicatorMapCustom = {
"     \ 'Modified'  : '✹',
"     \ 'Staged'    : '✚',
"     \ 'Untracked' : '✭',
"     \ 'Renamed'   : '➜',
"     \ 'Unmerged'  : '═',
"     \ 'Deleted'   : '✖',
"     \ 'Dirty'     : '✗',
"     \ 'Clean'     : '✔︎',
"     \ 'Ignored'   : '☒',
"     \ 'Unknown'   : '?'
"     \ }
" let g:NERDTreeGitStatusShowIgnored = 1

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

" ------------------------------------------------------------------------------
"  < LeaderF setting >
" ------------------------------------------------------------------------------
" CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
noremap <Leader>h :LeaderfMru<cr>

" ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
noremap <A-t> :LeaderfFunction!<cr>

" ALT+f 打开RG搜索
noremap <A-f> :Leaderf rg -i <space>

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
"  < vim-session setting >
" ------------------------------------------------------------------------------
" let g:session_directory=g:config . 'session'
" let g:session_autoload="no"
" let g:session_autosave="yes"
" let g:session_autosave_periodic = 60
" " let g:session_autosave_periodic = 0
" let g:session_autosave_sil = 1
" let g:session_command_aliases=1
" nnoremap <Leader>so :OpenSession<Space>
" nnoremap <Leader>ss :SaveSession<Space>
" nnoremap <Leader>sd :DeleteSession<CR>
" nnoremap <Leader>sc :CloseSession<CR>
" nnoremap <Leader>sv :ViewSession<CR>

" ------------------------------------------------------------------------------
"  < auto-pairs setting >
" ------------------------------------------------------------------------------
"  禁用 <c-h> 在插入中删除
let g:AutoPairsMapCh = 0

" ------------------------------------------------------------------------------
"  < nerdcommenter setting >
" ------------------------------------------------------------------------------
" 在左注释符之后，右注释符之前留有空格
let NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" ------------------------------------------------------------------------------
"  < vim-easy-align setting >
" ------------------------------------------------------------------------------
vmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------------------------
"  < AsyncRun setting >
" ------------------------------------------------------------------------------
nmap <Leader>; :AsyncRun<space>
" 常规模式下打开 quickfix
nnoremap <Leader>q :call asyncrun#quickfix_toggle(6)<cr>

" ------------------------------------------------------------------------------
"  < Vimux setting >
" ------------------------------------------------------------------------------
" 提示命令运行
map <Leader>vp :VimuxPromptCommand<CR>

" 运行VimuxRunCommand执行的最后一条命令
map <Leader>vl :VimuxRunLastCommand<CR>

" 检查流道窗格
map <Leader>vi :VimuxInspectRunner<CR>

" 关闭由VimuxRunCommand打开的vim tmux运行程序
map <Leader>vq :VimuxCloseRunner<CR>

" 中断运行程序窗格中运行的任何命令
map <Leader>vx :VimuxInterruptRunner<CR>

" 缩放运行器窗格（使用<bind-key> z还原运行器窗格）
map <Leader>vz :VimuxZoomRunner<CR>

" ------------------------------------------------------------------------------
"  < tags setting >
" ------------------------------------------------------------------------------
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
" let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
" if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
" endif

" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 禁用gutentags_plus默认键盘映射
" let g:gutentags_plus_nomap = 1

" ------------------------------------------------------------------------------
"  < Coc setting >
" ------------------------------------------------------------------------------
" CocInstall coc-phpactor
" CocInstall coc-yaml
" CocInstall coc-post
" CocInstall coc-rime
" CocInstall coc-markmap
" CocInstall coc-docker

let g:coc_global_extensions = [
            \ 'coc-marketplace',
            \ 'coc-lists',
            \ 'coc-highlight',
            \ 'coc-explorer',
            \ 'coc-snippets',
            \ 'coc-tabnine',
            \ 'coc-json',
            \ 'coc-vimlsp',
            \ 'coc-go',
            \ 'coc-phpls',
            \ 'coc-sql',
            \ 'coc-translator']

" 开启vim-airline集成
let g:airline#extensions#coc#enabled = 1
set signcolumn=yes
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" 使用 <tab> 触发补全并导航到下一个补全项
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" session
nmap <Leader>so :CocCommand session.load<CR>
nmap <Leader>ss :CocCommand session.save<CR>

" coc-explorer
nmap <Leader>ee :CocCommand explorer<CR>

" coc-translator
" popup
nmap <Leader>tt <Plug>(coc-translator-p)
" echo
nmap <Leader>te <Plug>(coc-translator-e)
" replace
nmap <Leader>tr <Plug>(coc-translator-r)

" coc-markmap
" Create markmap from the whole file
nmap <Leader>m <Plug>(coc-markmap-create)
" Create markmap from the selected lines
vmap <Leader>m <Plug>(coc-markmap-create-v)

" ------------------------------------------------------------------------------
"  < Go setting >
" ------------------------------------------------------------------------------
let g:go_def_mode                 = "gopls"
let g:go_info_mode                = "gopls"
let g:go_fmt_command              = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath        = 1
let g:go_list_type                = "quickfix"
let g:go_term_mode                = "split"

let g:go_highlight_types          = 1 " Highlight struct and interface names
let g:go_highlight_fields         = 1 " Highlight struct field names.
let g:go_highlight_functions      = 1 " Highlight function and method declarations
let g:go_highlight_function_calls = 1 " Highlight function and method calls
let g:go_highlight_operators      = 1 " Highlight operators such
let g:go_highlight_extra_types    = 1 " Highlight commonly used library types
let g:go_highlight_generate_tags  = 1 " Highlight go:generate directives

au FileType go nmap <leader>r <Plug>(go-run)

" ------------------------------------------------------------------------------
"  < vim-visual-multi setting >
" ------------------------------------------------------------------------------
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<leader>v' " replace C-n
let g:VM_maps['Find Subword Under'] = '<leader>v' " replace visual C-n

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

" ------------------------------------------------------------------------------
"  < Pangu setting >
" ------------------------------------------------------------------------------
"  『盘古之白』中文排版自动规范化的 Vim 插件

autocmd BufWritePre *.md call PanGuSpacing()
