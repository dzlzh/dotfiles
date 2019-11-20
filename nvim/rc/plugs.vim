" -----------------------------------------------------------------------------
"  < vim-plug >
" -----------------------------------------------------------------------------
let s:vimplug_exists=expand(g:config . 'autoload/plug.vim')
let s:vimplug_plugged=expand(g:config . 'plugged')

if !filereadable(s:vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . s:vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

call plug#begin(s:vimplug_plugged)

" Plugins for blendent
Plug 'flazz/vim-colorschemes'
Plug 'chuling/vim_equinusocio_material'

" Plugins for beautify
Plug 'vim-airline/vim-airline'                        " 美化状态栏
Plug 'vim-airline/vim-airline-themes'                 " 美化状态栏主题
Plug 'Yggdroot/indentLine'                            " 缩进提示线

" Plugins for file
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind']}
Plug 'pbrisbin/vim-mkdir'                             " 自动创建目录
Plug 'junegunn/fzf', {'do': './install --all'}        " FZF
Plug 'Yggdroot/LeaderF'

" Plugins for Git
Plug 'tpope/vim-fugitive'                             " Git
Plug 'airblade/vim-gitgutter'                         " Git Diff

" Plugins for Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" Plugins for Tmux
Plug 'christoomey/vim-tmux-navigator'                 " Tmux

" Plugins for code
Plug 'jiangmiao/auto-pairs'                           " 自动补全括号
Plug 'scrooloose/nerdcommenter'                       " 代码注释
Plug 'tpope/vim-surround'                             " 快速给单词/句子两边增加符号
Plug 'vim-scripts/repeat.vim'                         " .命令来重复上次插件使用的命令
Plug 'matze/vim-move'                                 " 向上和向下移动代码
Plug 'junegunn/vim-easy-align'                        " 快速对齐
Plug 'skywind3000/asyncrun.vim'                       " 异步构建和测试调度程序
Plug 'ludovicchabant/vim-gutentags'                   " ctags/gtags 自动更新
Plug 'skywind3000/gutentags_plus'                     " 自动处理好 gtags 数据库切换
Plug 'honza/vim-snippets'

" Plugins for autocomplete
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'zxqfl/tabnine-vim'                              " AI自动补全

" Plugins for golang
Plug 'fatih/vim-go', { 'for': 'go' }

" Plugins for wiki
if exists("g:vimwiki_path")
    Plug 'vimwiki/vimwiki'
endif

call plug#end()
