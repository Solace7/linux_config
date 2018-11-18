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
set termguicolors
hi Normal          ctermfg=252 ctermbg=none
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin '907th/vim-auto-save'
Plugin 'Lokaltog/vim-powerline'
Plugin 'syntaxconkyrc.vim'
Plugin 'colorizer'
Plugin 'morhetz/gruvbox'
Plugin 'Syntastic'
Plugin 'Valloric/YouCompleteMe'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
let g:auto_save_events = ["InsertLeave"]                                                

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

syntax on
colorscheme gruvbox

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
