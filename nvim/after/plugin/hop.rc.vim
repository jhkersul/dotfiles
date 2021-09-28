lua << EOF
require'hop'.setup()
EOF

nnoremap <leader>w <cmd>lua require'hop'.hint_words()<cr>
vnoremap <leader>w <cmd>lua require'hop'.hint_words()<cr>

