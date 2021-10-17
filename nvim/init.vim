source ~/.config/nvim/plug.vim

" General Configs
syntax on
let mapleader=","
set encoding=UTF-8
set clipboard=unnamedplus

" Indent
" set shiftwidth=2
set smartindent
set expandtab

" Theme
set termguicolors
colorscheme embark

" Line Config
set number relativenumber
set cursorline

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

"Clear highlight
nnoremap <esc><esc> :noh<CR>

" Searching ignoring case
set ignorecase
set smartcase

" Auto Formatting
nnoremap <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
let g:rustfmt_autosave = 1

