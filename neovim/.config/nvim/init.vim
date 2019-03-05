" -----------------------------------------------------------------------------
"  初始化
" -----------------------------------------------------------------------------
" Linux ~/.config/nvim
" Windows ~/AppData/Local/nvim
let g:iswindows = 0
let g:islinux = 0
let g:rc = '~/.config/nvim/rc/*.vim'
if (has("win32")|| has("win64"))
    let g:iswindows = 1
    let g:rc = '~/AppData/Local/nvim/rc/*.vim'
else
    let g:islinux = 1
    let g:rc = '~/.config/nvim/rc/*.vim'
endif
let g:isGUI = has("gui_running")                      " 判断是终端还是 GUI

let g:vimwikiPath = 'D:/workspace/vimwiki/'

let g:python_host_skip_check=1
let g:python_host_prog='D:/Python27/python.exe'
let g:python3_host_skip_check=1
let g:python3_host_prog='D:/Python/python.exe'

for f in split(glob(g:rc), '\n')
    exe 'source' f
endfor
