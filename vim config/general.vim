" General configuration for Vim/Neovim
" Last modified: 30 december 2013 
" Author: Ernst de Hart

" Encoding characters in UTF-8 for different versions of Vim
    set encoding=utf-8 fileencoding=utf-8 fileencodings=ucs-bom,utf8,prc
    scriptencoding utf-8

" Undo/Backup/MRU settings {

    "  Maximum number of changes that can be reverted in the current buffer.
    set undolevels=1000

    " Maximum number lines to save for undo.
    set undoreload=10000

    " Set undo dir.
    set undodir=C:\Dropbox\Vim\.vim\files-undo

    " Persistent undo.
    set undofile

    " Restore buffer list, marks are remembered for 9999 files, memory registers up to 512Kb are remembered.
    set viminfo=%,'9999,s512,nC:\\Dropbox\\Vim\\.vim\\files-viminfo 

    set backup
    set backupcopy=yes
    set backupdir=C:\Dropbox\Vim\.vim\files-backup
    " Store swap files in fixed location, not current directory.
    " Set backupdir=C:\Dropbox\Vim\.vim\files-backup\\,\var\tmp\\,\tmp\\,.
    let $TMP="C://Dropbox//Vim//.vim//files-tmp//"

    "Don't swap buffers in memory
    set noswapfile
    " set directory=C:\Dropbox\Vim\.vim\files-swapfiles
    " set directory for swap files
    set directory=C:\Dropbox\Vim\.vim\files-backup

    " set another viewdirectory for folds, so I can filter everyting out, which are not relevant for plugin Everything 
    set viewdir=C:\Dropbox\Vim\.vim\files-viewdir

" Tab settings {
    " Insert 4 spaces for a tab
    set tabstop=4
    " Number of space inserted for indentation
    set shiftwidth=2
   " Pressing tab in insert mode will use 4 spaces
    set softtabstop=4
    " Use spaces instead of tabs
    set expandtab
    " Always indent/outdent to nearest tabstop
    set shiftround
    " Indent to correct location with tab
    set smarttab


" Setting filetypes {
    au BufRead,BufNewFile *.module set filetype=php
    au BufRead,BufNewFile *.install set filetype=php
    au BufRead,BufNewFile *.test set filetype=php
    au BufRead,BufNewFile *.inc set filetype=php syntax=php
    au BufRead,BufNewFile *.profile set filetype=php
    au BufRead,BufNewFile *.view set filetype=php
    au BufNewFile,BufRead *.less set filetype=css
    au BufNewFile,BufRead *.html set filetype=html syntax=html
    au BufNewFile,BufRead *.tmp set filetype=html syntax=html
    au BufRead *.les set filetype=les

" }

" Indentation settings {
    " Turn on autoindenting of blocks, indent on same level as previous line.
    " And copy indent from current line when starting a new line too.
    set autoindent

    " Set number of space to display tab
    set ts=4

    " Copy the indentation of the previous line if autoindent doesn't know what to do (it's an eval, actually).
    set copyindent

    " Retain indentation on the next line
    set smartindent

    " String to put at the start of lines that have been wrapped "
    let &showbreak='➣➣  \'

    if v:version > 704 || v:version == 704 && has("patch338")
        " Patch 7.4.338, after wrapping lines, indent the wrapping lines too! Thanks to Chris Brabandt for fix.
        set breakindent
    endif
    "}


" Selection {
    " Change selected letters when write
    set selectmode=mouse,key

    " Select with SHIFT + ARROW for Vim-noobs
    set keymodel=startsel,stopsel

    " Enable select with mouse in insert mode
    set selection=exclusive

    " Can move cursor past end of line, where there are no characters, in visualblock mode
    set virtualedit=block

    " Visual selection automatically copied to clipboard
    set go+=a
    "}
    

" Search {
    " Ignore case when searching..
    set ignorecase
    " ...unless there's a capital letter in the query
    set smartcase
    " Search while you enter the query, not after
    set incsearch
    " Always substitute all letters, dont just substitute first hit on line alone
    set gdefault
    " Highlight search matches
    set hlsearch
"  }


" Tab completion {
    set wildmenu
    set wildmode=full
    set wildignorecase
    set wildchar=<Tab>
" }


" Terminal settings {
    " make terminal refreshing fast, instead refresh character for character.
    set ttyfast

    " Enable mouse in xterm
    set ttymouse=xterm2

    " Prefer redraw to scrolling for more than 3 lines, prevent glitches when you're scrolling.
    set ttyscroll=3


" Better Completion {
    set complete=.,w,b,u,t
    set completeopt=longest,menuone,preview
    set wildcharm=<TAB>

" When saving new file, surpress non-exist dir error and create new directory.
    function! s:MkNonExDir(file, buf)
        if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
            let dir=fnamemodify(a:file, ':h')
            if !isdirectory(dir)
                call mkdir(dir, 'p')
            endif
        endif
    endfunction
    augroup BWCCreateDir
        autocmd!
        autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
    augroup END

" Overige settings {

" Don't get my native language in Vim menu:
    let $LANG = 'en'

" Sets the language of Gvim menu. 
    set langmenu=en_US.UTF-8

" Allow backspacing over everything in insert mode.
    set backspace=indent,eol,start

" Make backspace delete characters. 
    set backspace=2

" Encrypt it.
    set cm=blowfish

" To show pages using `more` in command outputs.
    set more

" If I quit without saving, prompted to save or exit anyway.
    set confirm

" Start diff mode with vertical splits.
    set diffopt=vertical

" Set report, notify of allwhole line changes, with everything above 0 as minimum to report.
    set report=0

" Allows you to have multiple buffers open, perserving undo after save, multiple editor.
    set hidden

" Remember more commands and search history (default: 20).
    set history=1000

" Marco's.
    let @s="S*gvS*"

" Enable per-directory .vimrc files.
    set exrc   

" Dont update viewport until the marco has completed for faster processing.
    set lazyredraw

" Break line without break the word.
    set linebreak

" 1 space, not 2, when joining sentences.
    set nojoinspaces                      

" Set your Vi(m) session to allow pattern matching with special characters (ie: newline), extend regexes.
    set magic

" If there are two windows with scroll bind option enabled, scroll them simultaneously.
    setl scrollbind

" Scrolling asynchrously in splitted windows, even with same buffer.
    set noscrollbind

" Automatically enable mouse usage, but don't forget to feed him sometimes.
    set mouse=a

" Hide mouse when typing.
    set mousehide

" Disable error bells.
    set noerrorbells

" Alphabet too, with C-A and C-X.
    set nrformats=alpha

" Specify a function to be used for Insert mode omni.
    set omnifunc=syntaxcomplete#Complete

" Open standard in the directory of the buffer, when i press A-o :browse e
    set browsedir=buffer

" The Vanilla Vim is not so good in formatting lines, so improve them: {

    " Recognize numbered lists
     set formatoptions+=n 

    " Use indent from 2nd line of a paragraph
     set formatoptions+=2 

    " Don't break lines that are already long
     set formatoptions+=l 

    " Break before 1-letter words
     set formatoptions+=1 

    " Delete comment character when joining commented lines, so two lines of comment becomes one line when joining, without comment mark.
    if v:version + has("patch541") >= 704
        set formatoptions+=j
    endif

    " Don't continue comment mark after press 'o' when youre on a commented line
     set formatoptions -=cro

    " See the help under formatoptions for details
     set formatoptions=tqw
" }

" Prevent Vim from clobbering the scrollback buffer. Reference: http://www.shallowsky.com/linux/noaltscreen.html
    set t_ti= t_te=

" 180 characters helps the readability.
    set textwidth=180    

" Wrap 2 characters from the edge of the window
    "set wrapmargin=2
