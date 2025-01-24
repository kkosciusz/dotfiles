-- pick colorscheme from all installed ones
local telescope = require("telescope.builtin")
local function colorscheme_picker()
  vim.cmd("doautocmd User LazyColorscheme")
  telescope.colorscheme({ enable_preview = true, ignore_builtin = true })
end
vim.keymap.set("n", "<space>uc", colorscheme_picker, { desc = "Colorscheme with preview" })

-- executing lua lines/files
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- quickfix navigation
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- lsp
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
