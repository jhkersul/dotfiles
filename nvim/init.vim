source ~/.config/nvim/plug.vim

" General Configs
syntax on
let mapleader=","
set encoding=UTF-8
set clipboard=unnamedplus

" Indent
set shiftwidth=2
set smartindent
set expandtab

" Theme
set termguicolors
colorscheme embark

" Line Config
set number relativenumber
set cursorline

" File Explorer
nnoremap <leader>t <cmd>Lexplore<cr>

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

