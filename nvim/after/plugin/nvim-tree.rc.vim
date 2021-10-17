lua<<EOF
require'nvim-tree'.setup()
EOF

nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>


