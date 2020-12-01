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
    let g:config=expand('~/AppData/Local/nvim/')
else
    let g:islinux=1
    let g:config=expand('~/.config/nvim/')
endif

" -----------------------------------------------------------------------------
"  模块加载
" -----------------------------------------------------------------------------
" 加载文件
command! -nargs=1 LoadScript exec 'so '.g:config.'/'.'<args>'

if filereadable(g:config . 'preload.vim')
    LoadScript preload.vim
endif

LoadScript rc/setting.vim
LoadScript rc/plugs.vim
LoadScript rc/plug-setting.vim
LoadScript rc/keymaps.vim
LoadScript rc/commands.vim

if filereadable(g:config . 'afterload.vim')
    LoadScript afterload.vim
endif
