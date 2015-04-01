""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" typegame.vim
"       TypeGame v1.0: 2012.8.6
"               Be completed and work (relatively) normally.
"
" Author: Shihira Fung (fengzhiping@hotmail.com)
"
" Description: This script simulates type game as Typeeasy.
"       You can check this gif for detail:
"
" Usage:
"       Simply put this file in the ~/.vim/plugin directory,
"       and run :ToggleType to start.
"
"       :ToggleType    toggle TypeGame in place
"                       DON'T run this command the second time
"                       unless you've run ExitType to delete
"                       all buffers that TypeGame created.
"
"       :ExitType      clear all TypeGame buffers, and recover
"                       the original buffer in place.
"               
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:InitTypeBuffer()
        let src_con = getline(1, '$')
        let src_buf = winbufnr(winnr())

        "create a temporary buffer
        edit [TypeGame]
        setl buftype=nofile
        setl nobuflisted
        setl nocin noai nosi
        let typ_buf = winbufnr(winnr())
        let b:src_buf = src_buf

        "copy to new buffer
        let typ_con = []
        for l in src_con
                let typ_con += [l, '']
        endfor
        call setline(1, typ_con)

        return typ_buf
endfunction

function! s:CheckTypeError()
        let lns = getline(1, '$')
        let lni = 0
        let err_pat = ''

        while lni < len(lns)
                "for a specified length, compare if two strings equal
                let sub_len = len(lns[lni + 1])
                if lns[lni][:sub_len - 1] != lns[lni + 1] && sub_len > 0
                        if err_pat != "" | let err_pat .= '\|' | endif
                        let err_pat .= '\%' . (lni + 2) . 'l'
                endif
                let lni += 2
        endwhile

        if err_pat != "" | exec 'match Error /'. err_pat . '/'
        else | match none | endif
        
                
endfunction

function! s:UpdateSpeed()
        let start_t = b:start_t
        let press_t = b:press_t

        "head for the statistic window and clear it
        if !bufloaded("[TypeStat]")
                new [TypeStat]
                setl buftype=nofile
                setl nobuflisted
                1 wincmd _
        else
                exec bufwinnr("[TypeStat]") . " wincmd w"
                normal ggVGd
        endif

        let now = localtime()
        let dt = now - start_t
        call setline(1, '[Press Times: '.press_t / 2.
                \ ']    [Duration: '.dt.
                \ ']    [Speed: '.(press_t * 60 / dt / 2).' lpm]')

        "return the type window
        exec bufwinnr("[TypeGame]") . " wincmd w"
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"global functions that called by commands directly

function! g:ToggleType()
        let tbnr =  s:InitTypeBuffer()
        normal 2G0

        "this script depends strictly on parity, here is trying to 
        "improve its robustness. if all you want is to make troubles,
        "sorry but this script is not for you.
        nnoremap <buffer> dd 65536x
        inoremap <buffer> <cr> <esc>jI
        nmap <buffer> o <cr>

        "the two autocmds make going up a trouble, so I solve it with mapping
        autocmd CursorMoved  <buffer> if line('.') % 2 | exec (line('.') + 1) | endif
        autocmd CursorMovedI <buffer> if line('.') % 2 | exec (line('.') + 1) | endif
        nnoremap <buffer> k 2k
        noremap <buffer> <Up> 2k

        "update statistic window on keypress
        autocmd InsertEnter  <buffer> let b:start_t = localtime() | let b:press_t = 0
        autocmd CursorMovedI <buffer> let b:press_t += 1
        autocmd CursorMovedI <buffer> call s:UpdateSpeed()

        autocmd CursorMovedI <buffer> call s:CheckTypeError()
        autocmd CursorMovedI <buffer> if len(getline(line('.'))) >= len(getline(line('.') - 1))
                                \ | call feedkeys("\<down>") |
                                \ if line('.') == line('$') | call feedkeys("\e") | endif | endif
endfunction

function! g:ExitType()
        if bufloaded("[TypeStat]")
                exec bufwinnr("[TypeStat]") . "wincmd w"
                let ts_buf = winbufnr(winnr())
                close
        endif
        exec bufwinnr("[TypeGame]") . "wincmd w"
        let tg_buf = winbufnr(winnr())

        exec "buffer " . b:src_buf
        exec "silent! bdelete " . ts_buf
        exec "silent! bdelete " . tg_buf
        match none
endfunction


command! ToggleType call g:ToggleType()
command! ExitType  call g:ExitType()
