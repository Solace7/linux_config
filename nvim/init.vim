set nocompatible              " be iMproved, required
set laststatus=2	      " Always show statusline
set encoding=utf-8	      " Necessary to show Unicode glyphs
let g:Powerline_symbols = 'fancy'
let g:auto_save=1 "Enable AutoSave on Vim startup
set wildmenu
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set wrap linebreak nolist
set number
set spell spelllang=en_us
hi Normal          ctermfg=252 ctermbg=none
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/plugged')
Plug '907th/vim-auto-save'
Plug 'Lokaltog/vim-powerline'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'dense-analysis/ale'
call plug#end()            " required
let g:auto_save_events = ["InsertLeave"]
syntax on
colorscheme gruvbox
let g:airline_theme='gruvbox'

"Instant Markdown Settings
let g:instant_markdown_slow = 1

"Tagbar Settings
nmap <F8> :TagbarToggle<CR>

"Nerdtree Settings
map <F7> :NERDTreeToggle<CR>
