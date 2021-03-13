" ------- lsp ------------
" :lua << EOF
"   local nvim_lsp = require('lspconfig')

"   local on_attach = function(client, bufnr)
"     require('completion').on_attach()

"     local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
"     local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

"     buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

"   end

"   local servers = {'gopls'}
"   for _, lsp in ipairs(servers) do
"     nvim_lsp[lsp].setup {
"       on_attach = on_attach,
"     }
"   end
" EOF
" ------- lsp -----------
