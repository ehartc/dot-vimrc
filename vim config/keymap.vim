" Keymappings for Vim/Neovim
" Last modified: 30 december 2013
" Author: Ernst de Hart

" set my mapleader. Usually space would be the leader. But I use the scroll a lot more, so preferably use the space for scroll, like in the browsers (CUA compatible).
    let mapleader = "g"
    nnoremap <leader>g gg

" Keymapping for buffer navigation {  
    " Wait with delay of 400 milliseconds for input, instead the default 1000 ms. 
    " Because I want also to find f{char}, instead window navigation with f{hjkl}. Ttimeoutlen is starting with measurement.
    set timeout timeoutlen=400 ttimeoutlen=-1

    " Window navigation. However, find character h is still possible, don't type fast before press h. See above for finetuning.
    nnoremap <silent> fh :wincmd h<CR>
    nnoremap <silent> fj :wincmd j<CR>
    nnoremap <silent> fk :wincmd k<CR>
    nnoremap <silent> fl :wincmd l<CR>

    " Buffer handling, left/right are externally mapped to Alt-j/k
    nnoremap <silent> <right> :bn<CR>
    nnoremap <silent> <left> :bp<CR>

" }

" Without need to press shift, go into command modus. For the original use of ;, see plugin Clever-f. 
    nore ; :
    nore : ;

" Press same key ; again, to enter the command. If you really need to type ; in the command line (be frankly, it will never happen), C-v then ;
    autocmd CmdwinEnter * nnoremap <buffer> ; <CR><BS>

" Double tap s to save the buffer contents, more convienent than keep the pressure on the modifier keys to be CUA compatible.
    nnoremap <silent> ss :update<CR>

" Use CTRL-p for paste from system clipboard (works on Linux distro's and Windows)
    noremap <C-p> :set paste<CR>"*p:set nopaste<CR>

" F11 for fullscreen vim inside Windows, should be automatically fired on startup by the way.
    nnoremap <silent> <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" Move between lines, Alt-j and Alt-k are in Autokey mapped with up/down, still useful outside Vim. 
    map <silent> <up> {
    map <silent> <down> }

" I don't like the vertical line, but when I have horizontal window, make it so for visibility.
    nnoremap <A-n> :hi StatusLineNC GUIBg=#141414 guifg=#9a7824 gui=underline<CR>:hi StatusLine guifg=#9a7824 guibg=#141414 gui=underline<CR>:split<CR>

" Automatically jump to end of text thats pasted/yanked, feels inuitively.
    noremap <silent> y y`]
    noremap <silent> p p`]

" When the lines are wrapped, move lines humanfriendly, but make 10k to go up lines working too.
    nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap  0 g0
    noremap  $ g$

" Go to normal mode when rolling the fingers. I prefer it above 'jj' and it's even faster.
    inoremap jk <Esc>
    inoremap kj <Esc>

" Split the screen:
    nnoremap nn :vsplit<CR>
    nnoremap ns :split<CR>

" Faster way of appending double quotes (saves you hitting the shift key):
    inoremap '' ""<Left>

" Q to replay the marco.
    nnoremap Q @q

" Double tap q to close, much more convienent. If you want to record, leave the key q after pressing and then again, see :h timeout.
    nnoremap <silent> qq :q!<CR>

" Open the file under the cursor.
    nnoremap gt :tabnew<CR>:e#<CR>:e <cfile><cr>
    nnoremap gf :vsplit<CR>:wincmd l<CR>:e <cfile><cr>
    nnoremap gF :e <cfile><cr>

" Jump outside any parentheses or quotes, when your cursor is inside a closed region.
    inoremap jj <Esc>/[)}"'\]>]<CR>:nohl<CR>a

" Make em uppercase, not only the character, but the whole word. Which is more common.
    nnoremap gU <esc>mz<esc>gUiw`z
    vnoremap gU <esc>mz<esc>gvgU`z

" And make it lowercase.
    nnoremap gu <esc>mz<esc>guiw`z
    vnoremap gu <esc>mz<esc>gvgu`z


" Keymappings for Quickfix window { 
    " Toggle the Quixfix window (open and close)
    nnoremap qf :QFix<CR>
    " Toggle or close quickfix window
    command -bang -nargs=? QFix call QFixToggle(<bang>0)
    function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
    endfunction
" }

" Rotate windows clockwise.
    nnoremap <silent> sw <C-w>r 

" Delete line under your current position (Delete next-line).
    nnoremap dn majdd`a

" Useful for declaration, just press C-k for = (C-j is remapped with Autohotkey as Pagedown).
    inoremap <C-PageDown> <Space>=<Space>

" Make visual in insert mode possible to edit faster. Could think of any other use to display modifier keys in insert mode.
    inoremap <C-v> <ESC>V

"Ever make similar changes to two files and switch back and forth between them? (Say, source and header files?)
" nnoremap <TAB> :e#<CR>
" Noticed another way to do it. When call time measured, this way is faster than the above.
    nnoremap <TAB> 

" When open the line under you, stay in normal mode. I noticed I keep the normal modus most of the time.
    nnoremap O O<Esc>
    nnoremap o o<Esc>

" Look for the same words.
    nnoremap <S-LeftMouse> <LeftMouse>:<C-U>let @/='\<'.expand("<cword>").'\>'<CR>:set hlsearch<CR>

" The following mappings allows me to easily changing slashes in the current line, useful when you're switching between Windows and POSIX files.
    nnoremap <silent> <Leader>/ :let tmp=@/<Bar>s:\\:/:ge<Bar>let @/=tmp<Bar>noh<CR>
    nnoremap <silent> <Leader><Bslash> :let tmp=@/<Bar>s:/:\\:ge<Bar>let @/=tmp<Bar>noh<CR>

" Keep the cursor in place while joining lines.
    noremap J mzJ`z

" C-i is externally keymapped to send F2 to change the contents, for most CUA applications. Assign that to ciw.
    nnoremap <F2> ciw

" Unclear why M-; is received as » on Windows machines. To set the ratio normal.
    noremap » :winc =<CR>

" Travel to beginning of the line, while in insert modus.
    inoremap II <Esc>I

" Go to the end of line, seems to be faster to me.
    nnoremap aa A
    inoremap AA <Esc>A

" I mapped C-j and C-k to C-Pageup/down systemwide to switch between the tabs, in order to have them on home row. Apply the external input in Vim too:
    noremap <silent> <C-pageUp> :tabp<CR>
    noremap <silent> <C-pageDown> :tabn<CR>

" Make the dot repeat key also work in visual mode: 
    vnoremap . :norm.<CR>

" Underline the current line in normal mode when commenting.
" So it marks the current line with a, then :t. does copypase the line without modifying the register, ^v$ for whole line, replace with -, comment it, mark the upper line letter with uppercase (in case of various buffers) and go back to latest position. Saves me a lot of effort in long-term.
nnoremap gl <Esc>ma<Esc>^vU<Esc>EHART:<space><Esc>$a.<Esc>:t.<cr>^v$r-^:call NERDComment('n','toggle')<CR>`a$ja<Space><Esc>D`a<Esc>:call NERDComment('n','toggle')<CR>`all

" Open the GUI file browser.
    map <A-o> :browse confirm e<CR>

" Copypaste the full path of current buffer, useful when read/writing sessions.
    nnoremap <silent> cp :let @" = expand("%:p")<CR><Esc>p

" Same as above, but filename only. 
    nnoremap <silent> cf :let @" = expand("%")<CR><Esc>p

" Align/indent the whole buffer, but hold the cursor in the same spot
    nnoremap = maggVG=g;`a

" Analog to %, from matchit.
" nnoremap <expr> L :<C-U>call <SID>Match_wrapper('',1,'n') <CR>

"Use CTRL-t for create new tab, like when you're browsing. Faster to press with tt, and browse directly the files inside the new viewport.
    noremap <silent> tt :tabe<CR>:Unite -auto-resize file file_mru everything<cr>
    noremap <C-t> :tabe<CR>

" Use Esc to hide search highlights, which is mapped to M-q as recurring event.
    nnoremap <silent> <Esc> :nohl<CR>

" Aligning keys in a more logical way {
    nnoremap <leader>l >>
    nnoremap <leader>h <<
    nnoremap <C-l> >>
    nnoremap <C-h> <<
    vnoremap <C-l> >><Esc>
    vnoremap <C-h> <<<Esc>
" }

"' Go to older (g;) of newer change (g,), like backspace in every internet browser brings you back to the previous page.
    nnoremap <Backspace> g;

" Escape in command line, to enable navigation in command line. Do insert to execute the command.
    cnoremap jk <C-f>
    cnoremap kj <C-f>

" Toggle obfuscation with ROT13, when pass file on work. And encrypt then. But someone could easily figure it out.
    nnoremap <f8> mzggg?G`z

" When I do leader-e, I mark it. With C-e, it enables me to go back. And C-e again to back again before I pressed C-e. With upper case instead lower case, to enable you to switch between buffers.
    nnoremap <leader>e mE
    nnoremap <C-e> mZ`EmS`ZmE`S

" Visual select block with double Enter.
    nnoremap <CR><CR> vip

" I remapped Del with A-d in autohotkey. Let delete that word with the A-d. 
    noremap <Del> <ESC>diwi

" When you press o or O to create a new line in vim, it's intelligent enough with where to put the cursor, almost always getting the indentation right. 
" However, if you press esc after creating line then press i to insert again, the cursor is at the beginning of the ruler. So fix that little glitch on empty lines:
    function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_ddO"
    else
        return "i"
    endif
    endfunction

nnoremap <expr> i IndentWithI()

" This last mapping lets me quickly open up ~/.vimrc so I can add new things on the fly.
" nnoremap <leader>v <C-w><C-v><C-l>:e $MYVIMRC<cr>

" I also work with CSS, I like the CSS properties sorted, so here’s a mapping which automatically sorts CSS tags for me:
    nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Fix move out of EasyClip.
    nnoremap M YD

" I have folds mapped to s, on home row. I found % slower to press. z is actually faster to press. And z is mapped to s for folding purposes.
    noremap z %

" Change inside tags like <div>.
    nnoremap c. T>vt<di
    nnoremap c, vt<di

" Run function.
    nnoremap <leader>d  :let last_search=@/<Bar> ?^\w? mark c<Bar> noh<Bar> echo getline("'c")<Bar> let @/ = last_search<CR>

" Repeat it. It feels better to have it on home row than curling your hand, in order to reach it.
    nnoremap " .
    nnoremap ' .

" Move visual block.
    vnoremap <silent> J :m '>+1<CR>gv=gv
    vnoremap <silent> K :m '<-2<CR>gv=gv

" Underscores are like visible spaces. So the alt version of space is " underscore, I found it faster to type.
    inoremap <A-Space> _
    cnoremap <A-Space> _

" gc previously changed text. (|gv| but for modification.)
    noremap gc :<C-U>silent!normal!`[v`]<CR>

" Replace the word in the search
    nnoremap <leader>r :%s/\<<C-r>=expand('<cword>')<CR>\>/



" -----------------------------------------------------------
"                    PLUGIN KEYMAPPING
" -----------------------------------------------------------
" go to next match in visual mode too {
    vnoremap n <Plug>(asterisk-*)

" Map surround.
    nnoremap d" ds" 
    nnoremap d' ds' 
    nnoremap d( ds( 
    nnoremap d) ds) 
    nnoremap d] ds] 
    nnoremap d[ ds[ 
    nnoremap d{ ds{ 
    nnoremap d} ds} 

" Try the plugin Smoothscroll. You will thank me eternally {
    nnoremap <silent> <Space> :call smooth_scroll#down(&scroll, 25, 3)<cr>
    nnoremap <silent> <PageUp> :call smooth_scroll#up(&scroll, 12, 3)<cr>

" NERDTreeToggle, the latest vertical resize is actually a hotfix for faulty GoldenRatio {
    noremap <silent> <leader>o :call NTFinderP()<CR>:vertical resize 35<CR>

" Run vCoolor
    nnoremap <silent> <leader>c  :VCoolor<CR>

" Smartpairs (absolutely, try it for an once)
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

" Toggle comment (commenting out or commenting in)
    map cc <plug>NERDCommenterToggle

" Go directly to the U- undo tree, otherwise you wouldn't open it anwyay. 
    nnoremap <leader>u :UndotreeToggle<CR>:wincmd h<CR> 

" Fix like D but with register, see plugin easyclip.
    nnoremap M YD

" Make it easy to repeat marco.
    nnoremap Q @q

" Result of default EasyClip, remap else to 'add mark'. To use gm for 'add mark' instead of m.
    nnoremap gm m

" Find the next occurrence of the character under the cursor, if you do it fast. Otherwise, it will look for the character 'f'.
    nnoremap ff xhp/<CR>-<CR>

" Maps for haya14busa incsearch.
" ------------------------------
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    let g:incsearch#auto_nohlsearch = 1
    map x  <Plug>(incsearch-nohl-n)
    map X  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)


" When words have uppercase, move to them: 
" ----------------------------------------
    map <silent> w <Plug>CamelCaseMotion_w
    map <silent> b <Plug>CamelCaseMotion_b
    map <silent> e <Plug>CamelCaseMotion_e
    sunmap w
    sunmap b
    sunmap e
    omap <silent> iw <Plug>CamelCaseMotion_iw
    xmap <silent> iw <Plug>CamelCaseMotion_iw
    omap <silent> ib <Plug>CamelCaseMotion_ib
    xmap <silent> ib <Plug>CamelCaseMotion_ib
    omap <silent> ie <Plug>CamelCaseMotion_ie
    xmap <silent> ie <Plug>CamelCaseMotion_ie

" Open taglist
    nnoremap <leader>t :TlistToggle<CR>:wincmd l<CR>:vertical resize 35<CR>

"SuperTab like snippets behavior.
imap <expr><C-l> neosnippet#expandable_or_jumpable() ?
	  \ "\<Plug>(neosnippet_expand_or_jump)"
	  \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><C-l> neosnippet#expandable_or_jumpable() ?
	  \ "\<Plug>(neosnippet_expand_or_jump)"
	  \: "\<C-l>"


" -----------------------------------------------------------
"                      UNITE KEYMAPPINGS 
" -----------------------------------------------------------
"" Double tap capslock (is remapped as modifier ctrl) activates Unite line.
    nnoremap <silent> df :Unite line -prompt-direction="top" -auto-resize -auto-highlight -start-insert<CR>
    nnoremap <silent> <F9> :Unite -auto-resize file file_mru everything<cr>
    inoremap <silent> <F9> <Esc>$a

" When double tap ;;, instead the command, you navigate through the bufferlist.
" cnoremap ; Unite buffer<CR>
    cnoremap ; <Esc>@:


" Unite keymaps { 
    function! s:unite_settings() "{
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-PageUp>   <Plug>(unite_select_next_line)
    imap <buffer> <C-PageDown>   <Plug>(unite_select_previous_line)
    nmap <buffer> <C-PageUp>   <Plug>(unite_select_next_line)
    nmap <buffer> <C-PageDown>   <Plug>(unite_select_previous_line)
    imap <buffer> <F9>    <Plug>(unite_exit)
    imap <buffer> qq      <Plug>(unite_exit)
    nmap <buffer> qq      <Plug>(unite_exit)
    imap <buffer> df      <Plug>(unite_exit)
    nmap <buffer> df      <Plug>(unite_exit)
    imap <buffer> diw     <Delete> 
    imap <buffer> ;       <CR>
    nmap <buffer> ;       <CR>
    nmap <buffer> l       <CR>
    endfunction

    " Custom mappings for the Unite buffer.
    autocmd FileType unite call s:unite_settings()

"}

" -----------------------------------------------------------
"         Switch between different sources like ctrlP
" -----------------------------------------------------------
    let s:sources = [
        \ ['codesearch',],
        \ ['everything',],
        \]
    let s:index = 0
    function! s:next()
    let s:index += 1
    if s:index >= len(s:sources)
        let s:index = 0
    endif
    call unite#start(s:sources[s:index])
    endfunction
    function! s:bind()
    nmap <silent><buffer> <C-y> :call <SID>next()<CR>
    imap <silent><buffer> <C-y> <Esc>:call <SID>next()<CR>
    endfunction

    augroup unite_switch
    autocmd!
    autocmd FileType unite call <SID>bind()
    augroup END
