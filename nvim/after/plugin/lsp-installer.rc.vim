lua << EOF
local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Customize the options passed to the server
    if server.name == "rust_analyzer" then
        opts.settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            }
        }
    end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
EOF

