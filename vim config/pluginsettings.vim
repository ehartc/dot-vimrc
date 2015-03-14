" Config for plugins {

" Set up Matchit, for extending % for tags such as </div>.
    runtime macros/matchit.vim

" Key for running smartpairs in the selection mode
" For extending selection with IN-mod (like vi").
" Default is 'm'.
    let g:smartpairs_nextpairs_key_i = '+'
    let g:smartpairs_start_from_word = 1

" Key for running smartpairs in the selection mode
" For extending selection with ABOVE-mod (like va")
" Default is 'M'
    let g:smartpairs_nextpairs_key_a = '~'

    let g:AutoPairsFlyMode = 0

" Place the tag list window on right.
    let Tlist_Use_Right_Window   = 1

" The MRU plugin will reuse the current window.
    let MRU_Use_Current_Window = 1 

" Ag location, when running on Windows.
    let g:agprg="C:/Dropbox/Vim/vim74/ag.exe --column --smart-case"

" Let g:tagbar_ctags_bin=
    let g:easytags_cmd = 'C:\Dropbox\Vim\vim74\ctags58\ctags.exe'
    let g:TE_Ctags_Path = 'C:\Dropbox\Vim\vim74\ctags58\ctags.exe'
    let TE_Ctags_Path = 'C:\Dropbox\Vim\vim74\ctags58\ctags.exe'

" Timestamp config lines scan.
    let g:timestamp_modelines = 10

" Vimproc {
    let g:vimproc#dll_path= "C:\Dropbox\Vim\.vim\bundle\vimproc\autoload\vimproc_win32.dll"

" Unite    {
" Change the output format of Unite: 
   let s:filters = {
   \   "name" : "preferred_unite_output",
   \}
   function! s:filters.filter(candidates, context)
      for candidate in a:candidates
         let bufname = bufname(candidate.action__buffer_nr)
         let filename = fnamemodify(bufname, ':p:t')
         let path = fnamemodify(bufname, ':p:h')

         " Customize output format.
         let candidate.abbr = printf("[%s] %s\\%s", filename, path, filename)
      endfor
      return a:candidates
   endfunction

   call unite#custom#source('buffer', 'converters', 'preferred_unite_output')

    let g:unite_source_codesearch_ignore_case = 1
    let g:unite_source_everything_cmd_path = 'C:/Dropbox/Vim/vim74/es.exe'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#custom#source('file,file/new,file_mru,buffer,file_rec',
    \ 'matchers', 'matcher_fuzzy')
    let g:unite_data_directory='~/.vim/.cache/unite'
    let g:unite_source_history_yank_enable=1
    if executable('ag')
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts='-i -r --line-numbers --nocolor --nogroup -S'
        let g:unite_source_grep_recursive_opt = ''
    endif


" Syntastic  {
    let g:syntastic_javascript_checkers = ['jsl']
    let g:syntastic_enable_signs = 1
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_style_error_symbol = '✠'
    let g:syntastic_warning_symbol = '∆'
    let g:syntastic_style_warning_symbol = '≈'
    " Configure syntastic syntax checking to check on open as well as save.
    let g:syntastic_check_on_open=1
    let g:syntastic_aggregate_errors=1
    let g:syntastic_auto_jump=2
    " Don"t show specific errors when editing HTML-types.
    let g:syntastic_html_tidy_ignore_errors = [ '<input> proprietary attribute "role"',
                                                    \'<i> proprietary attribute "rowid"',
                                                    \"trimming empty <i>",
                                                    \'<img> lacks "alt" attribute',
                                                    \"trimming empty <span>",
                                                    \"<input> proprietary attribute \"autocomplete\"",
                                                    \"proprietary attribute \"role\"",
                                                    \"proprietary attribute \"hidden\"",
                                                \]

" Neocomplete {
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#enable_auto_select = 0
    let g:neocomplete#enable_fuzzy_completion = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#force_overwrite_completefunc = 1
    let g:neocomplete#max_list = 10
    let g:neocomplete#use_vimproc = 1
    let g:neocomplete_enable_camel_case_completion = 0
    let g:neocomplete_enable_fuzzy_completion_start_length = 2

    " Fix the omnicompletion for NeoComplete with force.
    if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_force_omni_patterns.php= '\k\.\k*'
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    let g:neocomplete#sources#vim#complete_functions = {
            \     'Unite': 'unite#complete_source',
            \     'VimShell': 'vimshell#complete',
            \     'VimFiler': 'vimfiler#complete',
            \ }
    call neocomplete#custom#source('ultisnips', 'rank', 500)
    " Plugin key-mappings {
            function! CleverCr()
                if pumvisible()
                    if neosnippet#expandable()
                        let exp = "\<Plug>(neosnippet_expand)"
                        return exp . neocomplete#close_popup()
                    else
                        return neocomplete#close_popup()
                    endif
                else
                    return "\<CR>"
                endif
            endfunction
                "<CR> close popup and save indent or expand snippet.
            imap <expr> <CR> CleverCr()
                "<C-h>, <BS>: " close popup and delete backword char.
            inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
            "<TAB>: completion.
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    " }
    " Use honza's snippets.
    let g:neosnippet#snippets_directory='~/.vim/neosnippets'
        "Enable neosnippet snipmate compatibility mode
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Disable the neosnippet preview candidate window. Or it will ruin your overview, especially when splits are used. 
    set completeopt-=preview
" }
