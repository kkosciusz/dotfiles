vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        diagnosticMode = "openFilesOnly",
      }
    }
  }
})

vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
