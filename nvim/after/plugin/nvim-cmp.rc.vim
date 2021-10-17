lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  -- Spell language
  vim.opt.spell = true
  vim.opt.spelllang = { 'en_us' }

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user
        vim.fn["vsnip#anonymous"](args.body)
      end
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      -- For vsnip user
      { name = 'vsnip' },
      -- Spell complete
      { name = 'spell' },
      { name = 'buffer' },
    }
  })
EOF

