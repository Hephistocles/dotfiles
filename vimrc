"" Vundle stuff
set nocompatible              " be iMproved, required
filetype off                  " required
 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline' 
Plugin 'tpope/vim-fugitive'
Plugin 'Raimondi/delimitMate'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
 
Bundle "myusuf3/numbers.vim"
Bundle "wookiehangover/jshint.vim"
Bundle "git://git.code.sf.net/p/vim-latex/vim-latex"
Bundle "flazz/vim-colorschemes"
Bundle "lsdr/monokai"

call vundle#end()            " required
filetype plugin indent on    " required

"" Fluff
set nocompatible
syntax enable
set encoding=utf-8
set showcmd
filetype plugin indent on
set noet ci pi sts=0 sw=4 ts=4
let g:syntastic_check_on_open=1

"" enable the mouse
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

"" Display Configuration
set number " show line numbers
set numberwidth=5
set laststatus=2 " always show status bar
set cursorline
colorscheme Monokai
set splitbelow
set splitright
set cole=2

"" Whitespace
set nowrap
set tabstop=4 shiftwidth=2
set backspace=indent,eol,start
set scrolloff=10

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Custom remaps

"" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"" newline without insert mode
nmap <Leader>O O<Esc>
nmap <Leader>o o<Esc>

"" typo fixes
nmap :Q :q
nmap :W :w

"" Pane switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <Alt-q> {gq}

imap <C-Enter> <Enter><Esc>O

"" Plugin settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_FoldedEnvironments = ',subcase,case,definition,proof,theorem'
