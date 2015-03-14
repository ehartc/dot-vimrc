"     __   _(_)_ __ ___  _ __ ___
"      \ \ / / | '_ ` _ \| '__/ __|
"       \ V /| | | | | | | | | (__
"      (_)_/ |_|_| |_| |_|_|  \___|

" This vimrc changes a lot.  I'll try to document pieces of it whenever I have some spare minutes to kill.

" On Windows, use '.vim' instead of 'vimfiles': this makes synchronization across heterogeneous Windows/POSIX environments easier.
let s:MSWindows = has('win95') + has('win16') + has('win32') + has('win64')

if s:MSWindows
   set runtimepath=$VIM/.vim,$VIMRUNTIME,$VIM/vimfiles/after,$VIM/.vim/after
endif

 " Vi is soooo 1970. Who cares about vi?
set nocompatible

" Thanks Tim Pope
execute pathogen#infect()
syntax on
filetype plugin indent on

" Vim configuration
source $VIM\vim config\autocommands.vim       " The filename says it already
source $VIM\vim config\fold.vim               " Setting the folds properly
source $VIM\vim config\general.vim            " General things.
source $VIM\vim config\keymap.vim             " Map the keys for a better workflow.
source $VIM\vim config\pluginsettings.vim     " Customize the others plugin.
source $VIM\vim config\styling.vim            " Give Vim some style.
