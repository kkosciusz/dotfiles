vim.g.mapleader = '<space>'

vim.loader.enable()

require('config.lazy')
require('config.options')
require('config.diagnostics')
require('config.arista')
require('config.keymaps')
require('config.floterminal')
require('config.terminal')

-- sourcing lua lines/files
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- quickfix navigation
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- highlight yanked text for a short time
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Hihglight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
