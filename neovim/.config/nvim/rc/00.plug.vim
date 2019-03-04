" -----------------------------------------------------------------------------
"  < vim-plug >
" -----------------------------------------------------------------------------
call plug#begin('$VIM/plugged')

" Plugins for beautify
Plug 'iCyMind/NeoSolarized'                           " 配色
Plug 'bling/vim-airline'                              " 美化状态栏
Plug 'vim-airline/vim-airline-themes'                 " 美化状态栏主题
Plug 'Yggdroot/indentLine'                            " 缩进提示线

" Plugins for file
Plug 'scrooloose/nerdtree'                            " 文件管理器
Plug 'pbrisbin/vim-mkdir'                             " 自动创建目录
Plug 'kien/ctrlp.vim'                                 " 文件跳转
Plug 'mileszs/ack.vim'                                " 全文搜索
Plug 'tpope/vim-fugitive'                             " Git
Plug 'airblade/vim-gitgutter'                         " Git Diff

" Plugins for code
Plug 'majutsushi/tagbar'                              " 变量与函数列表
Plug 'jiangmiao/auto-pairs'                           " 自动补全括号
Plug 'scrooloose/nerdcommenter'                       " 代码注释
Plug 'tpope/vim-surround'                             " 快速给单词/句子两边增加符号
Plug 'vim-scripts/repeat.vim'                         " .命令来重复上次插件使用的命令
Plug 'matze/vim-move'                                 " 向上和向下移动代码
Plug 'junegunn/vim-easy-align'                        " 快速对齐
Plug 'w0rp/ale'                                       " 异步代码检测工具
Plug 'skywind3000/asyncrun.vim'                       " 异步构建和测试调度程序

" Plugins for autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Plugins for golang
Plug 'fatih/vim-go', { 'for': 'go' }

" Plugins for wiki
Plug 'vimwiki/vimwiki'

call plug#end()
