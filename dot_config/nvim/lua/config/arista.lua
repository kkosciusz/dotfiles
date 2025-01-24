-- Include Arista specific settings
local path = "/usr/share/vim/vimfiles/arista.vim"
if vim.fn.filereadable(path) ~= 0 then
  vim.cmd.source(path)
end
