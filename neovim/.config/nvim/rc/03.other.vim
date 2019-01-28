" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
"设置无备份文件
set nobackup
set nowb
set noundofile
set noswapfile

" PHP w 认为 $ 为单词的一部分
autocmd FileType php setlocal iskeyword+=$
