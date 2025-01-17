-- Include Arista specific settings
local path = vim.env.VIM .. "/vimfiles/arista.vim"
if vim.fn.filereadable(path) then
  vim.cmd.source(path)
end
