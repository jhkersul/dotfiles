lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF

" Lsp Finder
nnoremap <leader>cd <cmd>lua require'lspsaga.provider'.lsp_finder()<cr>
" Show Code Action
nnoremap <leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
" Show Hover Doc
nnoremap <leader>ch <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" Rename
nnoremap <leader>cr <cmd>lua require('lspsaga.rename').rename()<CR>
" signature help
nnoremap <leader>cs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" jump diagnostic
nnoremap [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

