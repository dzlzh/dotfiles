" -----------------------------------------------------------------------------
"  初始化
" -----------------------------------------------------------------------------
" Linux ~/.config/nvim
" Windows ~/AppData/Local/nvim
" 判断是终端还是 GUI
let g:isGUI=has("gui_running")
let g:iswindows=0
let g:islinux=0
if (has("win32")|| has("win64"))
    let g:iswindows= 1
    let g:config=expand('~/.config/nvim/')
else
    let g:islinux=1
    let g:config=expand('~/.config/nvim/')
endif

let g:rc=g:config . 'rc/*.vim'
let g:vimplug_exists=expand(g:config . 'autoload/plug.vim')
let g:vimplug_plugged=expand(g:config . 'plugged')
" let g:vimwiki_path=expand('')
" let g:python_host_prog=expand('')
" let g:python3_host_prog=expand('')

for f in split(glob(g:rc), '\n')
    exe 'source' f
endfor
