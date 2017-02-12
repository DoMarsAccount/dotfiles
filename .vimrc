set nocompatible              " be iMproved, required

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
" plugin from http://vimawesome.com/plugin/the-nerd-commenter
" per request of nerdcommenter
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" vim-airline related stuff
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-airline'
" plugin from http://vimawesome.com/plugin/vim-airline

Plugin 'valloric/youcompleteme'
" Plugin from http://vimawesome.com/plugin/youcompleteme

Plugin 'tomasr/molokai'
" plugin from http://vimawesome.com/plugin/molokai

Plugin 'junegunn/goyo.vim'
" plugin from http://vimawesome.com/plugin/goyo-vim

Plugin 'edkolev/tmuxline.vim'
" plugin from http://vimawesome.com/plugin/tmuxline-vim

Plugin 'terryma/vim-multiple-cursors'
" plugin from http://vimawesome.com/plugin/vim-multiple-cursors

Plugin 'scrooloose/syntastic'
" plugin from http://vimawesome.com/plugin/syntastic

Plugin 'easymotion/vim-easymotion'
" plugin from http://vimawesome.com/plugin/easymotion

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set guifont=System\ San\ Francisco\ Display:h18 

" for theming vim past the default macOS terminal theming
syntax enable
colorscheme molokai
let g:molokai_original = 1

if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif

" for sanity with the how vim handles tabbing
set tabstop=4
set expandtab
set shiftwidth=4

set laststatus=2
