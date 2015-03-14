" Autocommands for Vim/Neovim
" Last modified: 30 december 2013
" Author: Ernst de Hart

" Remove trailing spaces when writing the buffer:
" autocmd BufWritePre * :%s/\s\+$//e

" Automatically change into the directory of the buffer, when switching.
    au BufEnter * silent! lcd %:p:h

" Fix "press Enter" message, when starting Vim with opening file.
    au VimEnter * set shortmess=IA

" Don't continue comment mark after press 'o' when youre on a commented line
    au VimEnter * set formatoptions -=cro

" Execute fullscreen without timewait will not work, due to overhead in driver. Ugly patch, until this issue will be fixed.  {
        function! Wait(mil)
        let timetowait = a:mil . " m"
        exe 'sleep '.timetowait
        endfunction

    " Enable it:
        function! FixFullScreen()
        call Wait(1)
        call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
        call Wait(1)
        call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
        call Wait(1)
        call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
        endfunction

        autocmd VimEnter * call FixFullScreen()
" }


" Switch to the directory of the current file, unless it's a help file.
" Could use BufEnter instead, but then we have constant changing pwd.
    " autocmd BufReadPost * if &ft != 'help' | silent! cd %:p:h | endif

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>).
    au VimEnter * vmap <Enter> <Plug>(EasyAlign)

" Don't continue comment mark after press 'o' when you're on a commented line.
    au VimEnter * set formatoptions -=cro
    au BufEnter * set formatoptions -=cro

" Auoindent XML correctly.
    au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Display CSS well in small side-diwi window.
    au BufEnter * if &ft ==# 'css' | vertical resize 50 | endif

" Remove the buffers from list which are not viewed in tabs and windows. {
    function RemoveHiddenBuffers()
        let tpbl=[]
        call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
        for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
            silent execute 'bwipeout' buf
        endfor
    endfunction

" Faster to type it:
    au VimEnter * call CmdAlias('buuf', 'call RemoveHiddenBuffers() <bar> echo "The hidden buffers are removed!"')
    au VimEnter * call CmdAlias('line', 'set fillchars+=stl:\_')
    au VimEnter * call CmdAlias('local', 'cd /var/www/html/')
    au VimEnter * call CmdAlias('dir', 'cd %:p:h')
    au VimEnter * call CmdAlias('uf', 'Unite -auto-resize  -start-insert file file_rec/async')

    command! -nargs=* -range -bang EA <line1>,<line2>call easy_align#align('<bang>' == '!', 0, '', <q-args>)
