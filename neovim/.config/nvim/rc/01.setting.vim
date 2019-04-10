" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
set encoding=utf-8                                    " 设置内部编码
set fileencoding=utf-8                                " 设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     " 设置支持打开的文件的编码
set fileformat=unix                                   " 设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          " 给出文件的<EOL>格式类型

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
" 设置代码配色方案
syntax on
" set background=light
set background=dark
" colorscheme NeoSolarized
 colorscheme gruvbox
" hi Pmenu ctermbg=238 gui=bold
if g:islinux
    hi Normal guibg=NONE ctermbg=NONE
endif
" if has("termguicolors")
"     set termguicolors
" endif

if g:islinux 
    set mouse=a                                       " 在任何模式下启用鼠标
    set t_Co=256                                      " 在终端启用256色
    " 设置退出后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
    set t_ti= t_te=
endif

set shortmess=atI                                     " 去掉欢迎界面
set nowrap                                            " 设置不自动折行
set number                                            " 显示行号
set laststatus=2                                      " 启用状态栏信息
set cmdheight=2                                       " 设置命令行的高度为2，默认为1
set ruler                                             " 显示当前的行号列号
set showcmd                                           " 在状态栏显示正在输入的命令
set showmode                                          " 左下角显示当前 vim 模式

set cursorline                                        " 突出显示当前行
set cursorcolumn                                      " 突出显示当前列
set colorcolumn=81                                    " 80 个字符的位置显示一条竖线来警示

" 设置字体:字号（字体名称空格用下划线代替）
set guifont=Source\ Code\ Pro\ for\ Powerline:h14

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
set nocompatible                                      " 禁用 Vi 兼容模式
filetype on                                           " 启用文件类型侦测
filetype indent on                                    " 针对不同的文件类型采用不同的缩进格式
filetype plugin on                                    " 针对不同的文件类型加载对应的插件
filetype plugin indent on                             " 启动自动补全

set autoread                                          " 当文件在外部被修改，自动更新该文件
set completeopt=longest,menu                          " 自动补全配置
set wildmenu                                          " 增强模式中的命令行自动完成操作

set smartindent                                       " 启用智能对齐方式
set expandtab                                         " 将Tab键转换为空格
set tabstop=4                                         " 设置Tab键的宽度
set shiftwidth=4                                      " 换行时自动缩进4个空格
set smarttab                                          " 指定按一次backspace就删除shiftwidth宽度的空格
set backspace=2
set backspace=indent,eol,start

set hlsearch                                          " 高亮搜索
set incsearch                                         " 在输入要搜索的文字时，实时匹配
set ignorecase                                        " 搜索模式里忽略大小写
set smartcase                                         " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用

set foldenable                                        " 启用折叠
set foldmethod=indent                                 " indent 折叠方式
set foldlevelstart=1                                  " 开始编辑时总是关闭所有的折叠 (0)，关闭某些折叠 (1) 或者没有折叠 (99)
