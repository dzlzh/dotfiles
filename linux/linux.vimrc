" =====================================================================================
" << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =====================================================================================
"
" -------------------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -------------------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if (has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -------------------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -------------------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =====================================================================================
" << 以下为软件默认配置 >>
" =====================================================================================
"
" -------------------------------------------------------------------------------------
"  < Windows Gvim 默认配置 >
" -------------------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function Mydiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg1 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg1 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substiute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
         else
            let cmd = $VIMRUNTIME . '\diff'
         endif
         silent execute '!' . cmd . ' ' . opt . arg1 . ' ' .arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -------------------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置 >
" -------------------------------------------------------------------------------------
if g:islinux
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配

    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        runtime! debian.vim

        if has("syntax")
            syntax on
        endif

        set mouse=a        "在任何模式下启用鼠标
        "set t_Co=256       "在终端启用256色
        set backspace=2    "设置退格键可用

        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" =====================================================================================
" << 以下为用户自定义配置 >>
" =====================================================================================
"
" -------------------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -------------------------------------------------------------------------------------
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim

set nocompatible    "禁用 Vi 兼容模式
filetype off        "禁用文件类型侦测

if g:islinux
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

"使用Vundle来管理Vundle， 这个必须要有
Plugin 'VundleVim/Vundle.vim'

"以下为要安装或更新的插件，不同仓库都有
Plugin 'a.vim'
Plugin 'Align'
Plugin 'jiangmiao/auto-pairs'
Plugin 'bufexplorer.zip'
Plugin 'ccvext.vim'
Plugin 'cSyntaxAfter'
Plugin 'Yggdroot/indentLine'
Plugin 'Mark--Karkat'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'OmniCppComplete'
Plugin 'Lokaltog/vim-powerline'
Plugin 'repeat.vim'
Plugin 'wesleyche/SrcExpl'
Plugin 'std_c.zip'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'UltiSnips'
Plugin 'honza/vim-snippets'
Plugin 'TxtBrowser'

filetype plugin indent on

" -------------------------------------------------------------------------------------
"  < 编码配置 >
" -------------------------------------------------------------------------------------
set encoding=utf-8                                   "设置gvim内部编码
set fileencoding=utf-8                               "设置当前文件编码
set fileencodings=utf-8,ucs-bom,gbk,cp936,latin-1    "设置支持打开的文件编码

"文件格式，默认 ffs=dos,unix
set fileformat=unix                                  "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                         "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" -------------------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -------------------------------------------------------------------------------------
filetype on                     "启用文件类型侦测
filetype plugin on              "针对不同的文件类型加载对应的插件
filetype plugin indent on       "启用缩进
set smartindent                 "启用智能对齐方式
set expandtab                   "将TAB键转换为空格
set tabstop=4                   "设置TAB键的宽度
set shiftwidth=4                "换行时自动缩进4个空格
set smarttab                    "指定按一次backspace就删除shiftwidth宽度的空格
set foldenable                  "启用折叠
set foldmethod=indent           "indent折叠方式
set foldlevelstart=99           "打开文件的默认不折叠代码

" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新文件
set autoread

" 常规模式下输入 \s 清除行尾空格
nmap <Leader>s :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入  cM 清除行尾空格 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                   "搜索模式里忽略大小写
set smartcase

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 启用每行超过80列的字符提示（字体变蓝并加下划线）
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" -------------------------------------------------------------------------------------
"  < 界面配置 >
" -------------------------------------------------------------------------------------
set number
set laststatus=2
set cmdheight=2
" set cursorline
set nowrap
set shortmess=atI

" 设置 Gvim 窗口初始位置及大小
if g:isGUI
    winpos 400 0
    set lines=38 columns=120
endif

" 配色方colorscheme monokai
" colorscheme monokai
 
" -------------------------------------------------------------------------------------
"  < 界面配置 >
" -------------------------------------------------------------------------------------
set writebackup     "保存文件前建立备件，保存成功后删除
set nobackup        "设置无备份文件 

" -------------------------------------------------------------------------------------
"  < 以下为常用自动命令配置 >
" -------------------------------------------------------------------------------------
au BufRead,BufNewFile,BufEnter * cd %:p:h  



" =====================================================================================
" << 插件配置 >>
" =====================================================================================
"
" indentLine
nmap <leader>il :IndentLinesToggle<CR>

if g:isGUI
    let g:indentLine_char = "|"
    let g:indentLine_first_char = "|"
endif

let g:indentLine_color_term = 239

"neocomplcache
let g:neocomplcache_enable_at_startup = 1

"nerdcommenter
let NERDSpaceDelims = 1

"nerdtree
nmap <F2> :NERDTreeToggle<CR>

" std_c
let c_cpp_comments = 0

" Tagbar
nmap tb :TlistClose<CR>:TagbarToggle<CR>
let g:tagbar_width=30

" txtbrower
au BufRead,BufNewFile *.txt setlocal ft=txt

" ctags
set tags=./tags;

" UltiSnips
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
