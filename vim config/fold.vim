" Enables manual folding, in order to get my preferences working.
    set foldmethod=manual

" See :h foldcolumn
    set foldcolumn=1

" Deepest fold is 3 levels.
    set foldnestmax=3

" But have fold open by default, autofold should be not enabled. {
    set nofoldenable

" Load the viewport with his own settings per buffer.
    if !isdirectory(expand(&viewdir))|call mkdir(expand(&viewdir), "p", 451)|endif


" When viewing files from others with fold tags included, I noticed that their foldlevel are often conflicting with my preferences. 
    function FoldLevelFix()
        if(&foldlevel == 0)
            set foldlevel=1
    elseif(&foldlevel != 0)
            set foldlevel=0
        endif
    endfunction

" Wrote function, to check if the viewport contains any folds.
    function HasFoldedLine()
        let lnum=1
        while lnum <= line("$")
            if (foldclosed(lnum) > -1)
                return 1
            endif
            let lnum+=1
        endwhile
        return 0
    endfu

" Give location for fold layout and their settings.
    set viewoptions=cursor,folds,slash,unix
    let &viewdir="C:\\Dropbox\\Vim\\.vim\\files-viewdir"

" PHP {
   let php_htmlInStrings         = 1 " Syntax highlight HTML code inside PHP strings.
   let php_sql_query             = 1 " Syntax highlight SQL code inside PHP strings.
   " let php_noShortTags           = 1 " Disable PHP short tags.
   let php_parent_error_close    = 1
   let php_parent_error_open     = 1
   " let php_alt_comparisons       = 1
   " let php_alt_assignByReference = 1
" }


" ----------------------------------------------------------------------------------------------------------------------
"                                               Keymappings for folding 
" ----------------------------------------------------------------------------------------------------------------------
" I found the keys of Vim for folding not comfortable, so so let's rebind the keys.  {
    " Create fold, z is not on homerow. I don't use 's', so remap z to s. 
        vnoremap sf zf

    " za :When on a closed fold: open it. And vice versa.
        nnoremap sf zA

    " [z :Move to the start of the current open fold.
        nnoremap [s [z
        nnoremap s[ [z

    " ]z :Move to the end of the current open fold.
        nnoremap ]s ]z
        vnoremap ]s ]z
        nnoremap s] ]z
        vnoremap s] ]z

    " zj :Move downwards. to the start of the next fold.
        nnoremap <silent> sj :call NextGeslotenFold('j')<cr>
    "
    " zk :Move upwards to the end of the previous fold.
        nnoremap <silent> sk :call NextGeslotenFold('k')<cr>

    " zR :Open/close all folds
        nnoremap <silent> sl :call FoldLevelFix()<CR>

    " Create fold of function, to select just one line of function header.
        nnoremap sh v$%zf

    " When vap, press space to fold it
        vnoremap <Space> zf

    " Create fold of casebreak, to select just one line of function header.
        vnoremap sb /break<CR>zf
        nnoremap sb v/break<CR>zf

    " zE :Erase all folds.
        nnoremap sd zD
        nnoremap sD zE

" }



" ----------------------------------------------------------------------------------------------------------------------
"                                               Modify the fold layout      
" ----------------------------------------------------------------------------------------------------------------------

" I found the fold layout of Vim not extremely helpful, so let's modify it.  {
    function! UsefulFoldText() 
    " Add regex to find the relevant lines.
        let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
        let linesCount = v:foldend - v:foldstart + 1

        let foldSize = 1 + v:foldend - v:foldstart
        let lineCount = line("$")

    " Then abuse the error (E806) as indicator when passing a float as string. 
    " However, I would be interested in a better way to read the fold input with VimL. If you do know a way, let me know at ernst de hart dot gmail dot the default domain. 
        if has("float")
            try
                let foldPercentage = printf(" %.1f", (foldSize*1.0)/lineCount*100) . "% "
            catch /^Vim\%((\a\+)\)\=:E806/
                let foldPercentage = printf("| [of %d lines] |", lineCount)
            endtry
        endif

        " Tie the vars together.
        let linesCountText = '| ' . printf("%10s", lines_count . ' lines of Vi code') . ' - ' . foldPercentage . ' |'
        let foldchar       = matchstr(&fillchars, 'fold:\zs.')
        let foldtextStart  = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
        let foldtextEnd    = linesCountText . repeat(foldchar, 28)
        let foldtextLength = strlen(substitute(foldtextStart . foldtextEnd, '.', 'x', 'g')) + &foldcolumn

        " Keep in mind that the align-feature is already included below. 
        return foldtextStart . repeat(foldchar, winwidth(0)-foldtextLength) . foldtextEnd
    endfunction
    " Start it: 
    set foldtext=UsefulFoldText()

" }

" I would like to move between the folds only, instead text. {
    function! NextGeslotenFold(dir)
        " Use the same dir where the memory buffer resides.
        let cmd = 'norm!z' . a:dir
        let view = winsaveview()
        " Then count the folds.
        let [l0, l, open] = [0, view.lnum, 1]
        while l != l0 && open
            exe cmd
            let [l0, l] = [l, line('.')]
            let open = foldclosed(l) < 0
        endwhile
        if open
            call winrestview(view)
        endif
    endfunction
" }

