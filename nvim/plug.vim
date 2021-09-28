" Plugins Begin
call plug#begin(stdpath('data') . '/plugged')

" Color scheme
Plug 'embark-theme/vim', { 'as': 'embark' }
" Vim Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Git features
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Auto close parentheses
Plug 'cohama/lexima.vim'
" Language Server
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
" Language Server Installer (https://github.com/williamboman/nvim-lsp-installer)
Plug 'williamboman/nvim-lsp-installer'
" Treesitter - Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Auto Completion
Plug 'nvim-lua/completion-nvim'
" FuzzyFinder - Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Tests
Plug 'vim-test/vim-test'
" Debugging
Plug 'puremourning/vimspector'
" Devicons
Plug 'ryanoasis/vim-devicons'
" Easy Motion Like
Plug 'phaazon/hop.nvim'

" Plugins End
call plug#end()

