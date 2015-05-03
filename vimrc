"" Fluff
source ~/.vimPlugins
set nocompatible
syntax enable
set encoding=utf-8
set showcmd
filetype plugin indent on
set noet ci pi sts=0 sw=4 ts=4
set spell spelllang=en_gb

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
map <C-l> <C-W>l
map <C-h> <C-W>h
map <Alt-q> {gq}
imap <C-Enter> <Enter><Esc>O
imap <C-h> B
imap <C-l> w
imap <C-j> <Esc>gqjkA

cmap <C-a> <Home>
cmap <C-e> <End>

"" Plugin settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:syntastic_check_on_open=1
let g:ctrlp_match_window_bottom = 0
let g:LatexBox_quickfix=2
let g:LatexBox_build_dir='~/.latexfiles'
let g:LatexBox_Folding=1
let g:LatexBox_show_warnings=0
let g:LatexBox_fold_sections = ["part", "chapter", "section", "subsection", "subsubsection", "theorem", "proof", "definition", "case", "subcase"]
