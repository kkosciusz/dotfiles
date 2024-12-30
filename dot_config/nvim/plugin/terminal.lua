-- settings for terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Configure terminal mode at startup',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- small terminal window at the bottom of the editor
vim.keymap.set('n', '<space>st', function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
  vim.cmd.startinsert()
end)

-- double escape bails out from terminal mode
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>')
