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
"Plug 'glepnir/lspsaga.nvim' " ORIGINAL! Not working with nvim 0.5.1
Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim51' }
" Language Server Installer (https://github.com/williamboman/nvim-lsp-installer)
Plug 'williamboman/nvim-lsp-installer'
" Treesitter - Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Auto Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
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
"  Commentary
Plug 'b3nj5m1n/kommentary'
" File Tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Spell check
Plug 'f3fora/cmp-spell'
" Rust Vim
Plug 'rust-lang/rust.vim'

" Plugins End
call plug#end()

