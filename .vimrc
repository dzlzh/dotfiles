" -------------------------------------------------
" 默认配置修改
" -------------------------------------------------
set hlsearch                                        " 高亮搜索
set incsearch                                       " 在输入要搜索的文字时，实时匹配

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

runtime! debian.vim
if has("syntax")
    syntax on
endif

set mouse=a                    " 在任何模式下启用鼠标
set t_Co=256                   " 在终端启用256色
set backspace=2                " 设置退格键可用

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" -------------------------------------------------
"  < 编码配置 >
" -------------------------------------------------
set encoding=utf-8                                  " 设置vim内部编码
set fileencoding=utf-8                              " 设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1   " 设置支持打开的文件的编码

set fileformat=unix                                 " 设置新文件的<EOL>格式
set fileformats=unix,dos,mac                        " 给出文件的<EOL>格式类型

" -------------------------------------------------
"  < 编写文件时的配置 >
" -------------------------------------------------

set nocompatible                                      " 禁用 Vi 兼容模式
filetype on                                           " 启用文件类型侦测
filetype indent on                                    " 针对不同的文件类型采用不同的缩进格式
filetype plugin on                                    " 针对不同的文件类型加载对应的插件
filetype plugin indent on                             " 启动自动补全

set smartindent                                       " 启用智能对齐方式
set expandtab                                         " 将Tab键转换为空格
set tabstop=4                                         " 设置Tab键的宽度
set shiftwidth=4                                      " 换行时自动缩进4个空格
set smarttab                                          " 指定按一次backspace就删除shiftwidth宽度的空格
set foldenable                                        " 启用折叠
set foldmethod=indent                                 " indent 折叠方式
set foldlevelstart=99                                 " 打开文件是默认不折叠代码

set ignorecase                                        " 搜索模式里忽略大小写
set smartcase                                         " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用

" 当文件在外部被修改，自动更新该文件
set autoread

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 120 . 'v.\+', -1)

" 默认寄存器和系统剪贴板共享
set clipboard+=unnamed

" 设置 退出 vim 后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
set t_ti= t_te=

" 自动补全配置
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu

" 快速浏览和操作Buffer
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" -------------------------------------------------
"  < 界面配置 >
" -------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
set cursorcolumn                                      "突出显示当前列
set guifont=Source_Code_Pro_Semibold:h14              "设置字体:字号（字体名称空格用下划线代替）
set nowrap                                            "设置不自动折行
set shortmess=atI                                     "去掉欢迎界面

set ruler                                             " 显示当前的行号列号
set showcmd                                           " 在状态栏显示正在输入的命令
set showmode                                          " 左下角显示当前 vim 模式

" 设置代码配色方案
" 安装配色方案 https://github.com/altercation/vim-colors-solarized
syntax enable
let g:solarized_termcolors=256
set background=dark
colorscheme solarized                               "Gvim配色方案


" -------------------------------------------------
"  < 其他配置 >
" -------------------------------------------------
"设置无备份文件
set nobackup
set nowb
set noundofile
set noswapfile
