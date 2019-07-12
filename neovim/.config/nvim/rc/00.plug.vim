" -----------------------------------------------------------------------------
"  < vim-plug >
" -----------------------------------------------------------------------------
if !filereadable(g:vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . g:vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(g:vimplug_plugged)

" Plugins for blendent
Plug 'iCyMind/NeoSolarized'                           " Solarized
Plug 'morhetz/gruvbox'                                " gruvbox

" Plugins for beautify
Plug 'bling/vim-airline'                              " 美化状态栏
Plug 'vim-airline/vim-airline-themes'                 " 美化状态栏主题
Plug 'Yggdroot/indentLine'                            " 缩进提示线

" Plugins for file
Plug 'scrooloose/nerdtree'                            " 文件管理器
Plug 'pbrisbin/vim-mkdir'                             " 自动创建目录
Plug 'junegunn/fzf', {'do': './install --all'}        " FZF 文件搜索
Plug 'junegunn/fzf.vim'                               " FZF 文件搜索
" Plug 'mileszs/ack.vim'                                " 全文搜索
" Plug 'kien/ctrlp.vim'                                 " CtrlP 文件搜索

" Plugins for Git
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
Plug 'skywind3000/asyncrun.vim'                       " 异步构建和测试调度程序

" Plugins for wiki
if exists("g:vimwiki_path")
    Plug 'vimwiki/vimwiki'
endif

" Plugins for golang
Plug 'fatih/vim-go', { 'for': 'go' }

" Plugins for autocomplete
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Plug 'w0rp/ale'                                       " 异步代码检测工具
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'

call plug#end()
