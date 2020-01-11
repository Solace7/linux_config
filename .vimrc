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
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin '907th/vim-auto-save'
Plugin 'Lokaltog/vim-powerline'
Plugin 'syntaxconkyrc.vim'
Plugin 'colorizer'
Plugin 'morhetz/gruvbox'
Plugin 'Syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required
let g:auto_save_events = ["InsertLeave"]
syntax on
colorscheme gruvbox
let g:airline_theme='gruvbox'

"Instant Markdown Settings
let g:instant_markdown_slow = 1

"YCM Settings
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = '/home/sgreyowl/.vim/.ycm_extra_conf.py'
let g:ycm_register_as_syntastic_checker = 1 
let g:Show_diagnostics_ui = 1


"Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Tagbar Settings
nmap <F8> :TagbarToggle<CR>

"Nerdtree Settings
map <F7> :NERDTreeToggle<CR>
