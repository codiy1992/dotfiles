" ---
" --- Plugin <neovim/nvim-lspconfig>
" --- @link https://github.com/neovim/nvim-lspconfig/wiki
" ---
" --- Please Make Sure your "language server" is installed
" --- and executable path exists in "$PATH"
" ---
" --- About Language Server More Informations See https://langserver.org
" ---

lua << EOF
require'lspconfig'.gopls.setup{
  cmd = { "/Users/codiy/go/bin/gopls" }
}
-- vim.lsp.set_log_level("debug")
EOF


" --- Key Mappings
nnoremap <silent><leader>ls <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent><leader>ll <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent><leader>lg <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><leader>l; <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>l, <cmd>lua vim.lsp.diagnostic.goto_next()<CR>


