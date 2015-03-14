" GUI/Terminal config for Vim/Neovim
" Last modified: 30 december 2013 
" Author: Ernst de Hart

" If there is a false on GUI returned, then load the terminal scheme {
    if has("gui_running")
    try
        colorscheme Spink
    catch /E185/
        colorscheme jellybeans
    endtry
    
        set guioptions-=m       " remove menu bar
        set guioptions-=T       " remove toolbar
        set guioptions-=r       " remove right-hand scroll bar
        set guioptions-=L       " remove left-hand scroll bar
        set guioptions=c
    endif
" }

" Speed up syntax highlighting {
   set nocursorcolumn
   set nocursorline
   syntax sync minlines=100
   syntax sync maxlines=240
   " Don't try to highlight lines longer than 800 characters, in order to speed up the viewport.
   set synmaxcol=900
" }

" Editing {
    "" Use indents of 4 spaces
    set shiftwidth=4
    " Tabs are spaces, not tabs
    set expandtab
    " An indentation every four column
    set tabstop=4
    " Let backspace delete indent
    set softtabstop=4
    " Prevents inserting two spaces after punctuation on a join (J)
    set nojoinspaces
    " pastetoggle (sane indentation on pastes)
    set pastetoggle=<F12>
" }

" Block cursor blinking options for Linux, MacOS and Windows config {
    if $COLORTERM == 'gnome-terminal'
        au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_blink_mode on"
        au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_blink_mode off"
        au VimEnter * silent execute "!xterm -cr darkred"
    else
    " Blinking options of cursor
        set guicursor=n-v-c:block-blinkon0-blinkoff0
        set guicursor+=i:ver20-blinkwait1-blinkoff0
    endif
" }

" Statusline style options. Just be basic with essential info.
    set laststatus=2
    if $COLORTERM == 'gnome-terminal'
        set statusline +=%{fugitive#statusline()}
    endif

    set statusline+=%1*\ [%n]\                              " Buffer number
    set statusline +=%m                                     " Modified
    set statusline +=[%<%F\]%*                              " Full path
    set statusline +=%=                                     " Split it
    set statusline +=[%l/%L\ %P]\                           " Current line
    set statusline +=[%{strftime('%A\ %d\ %b\ @\ %H:%M\')}] " Current time

    if $COLORTERM == 'gnome-terminal'
        au InsertEnter * hi StatusLine ctermfg=136 ctermbg=NONE gui=bold
        au InsertLeave * hi StatusLine ctermfg=88 ctermbg=NONE gui=bold
    endif

" ----------------------------------------------------------------------------------------------------------------------
"                                                   NERDTree settings
" ----------------------------------------------------------------------------------------------------------------------
    function! NTFinderP()
        " Check if NERDTree is open
        if exists("t:NERDTreeBufName")
            let s:ntree = bufwinnr(t:NERDTreeBufName)
        else
            let s:ntree = -1
        endif
        if (s:ntree != -1)
            " If NERDTree is open, close it.
            :NERDTreeClose
        else
            " Try to open a :Rtree for the rails project
            if exists(":Rtree")
                " Open Rtree (using rails plugin, it opens in project dir)
                :Rtree
            else
                " Open NERDTree in the file path
                :NERDTreeFind
            endif
        endif
    endfunction


" ----------------------------------------------------------------------------------------------------------------------
"                                                   Tabline settings
" ----------------------------------------------------------------------------------------------------------------------
    if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
        finish
    endif
    let g:loaded_tabline_vim = 1

    function! Tabline()
        let s = ''
        for i in range(tabpagenr('$'))
            let tab = i + 1
            let winnr = tabpagewinnr(tab)
            let buflist = tabpagebuflist(tab)
            let bufnr = buflist[winnr - 1]
            let bufname = bufname(bufnr)
            let bufmodified = getbufvar(bufnr, "&mod")

            "let s .= '%' . tab . 'T'
            let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
            "let s .= ' ' . tab .':'
            if bufmodified
                let s .= ' [+! '. (bufname != '' ? ''. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
            else
                let s .= (bufname != '' ? ' ['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
            endif
        endfor

        let s .= '%#TabLineFill#'
        return s
    endfunction
    set tabline=%!Tabline()



" ----------------------------------------------------------------------------------------------------------------------
"                                                   Overige settings
" ----------------------------------------------------------------------------------------------------------------------
" Don't show current mode in the bottom.
    set noshowmode

" Add line to see where your cursor is, but only in the current buffer.
    set cursorline
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline

" Set report, notify of allwhole line changes, with everything above 0 as minimum to report.
    set report=0

" Dark background, switch syntax
    set background=dark                            

" Number width left of this text, smaller is more compact.
    set numberwidth=1

" Enable vim/neovim relative number.
    set rnu                                        

" Show the filename in the window titlebar.
    " set title                                      

" Display incomplete commands.
    set showcmd                                    

" Highlight matching braces/tags/parenthesis.
    set showmatch

" Tenths of a second to show the matching paren, when 'showmatch' is set.
    set matchtime=1

 " Make < and > as well as match pairs.
    set matchpairs+=<:>

" Fix relativenumber, always show the current line number between the relative numbers, instead null.
    au BufEnter * set nu
    au BufEnter * set relativenumber

"" Keep more bufferlines context when scrolling.
    set scrolloff=3

" Puts new split windows to the bottom of the current.
    set splitbelow

" Puts vertical windows to right, instead of left.
    set splitright
