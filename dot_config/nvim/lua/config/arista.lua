-- Include Arista specific settings
local path = "/usr/share/vim/vimfiles/arista.vim"
if vim.fn.filereadable(path) ~= 0 then
  -- This botches all autocommands, disable for now
  -- vim.cmd.source(path)
  -- Selected entries included
  vim.cmd([[syn match bugNumber "\c\<BUG\d\+"]])
  vim.cmd([[hi def link bugNumber Todo]])
  vim.g.python_recommended_style = 0
  vim.opt.shiftwidth = 3
  vim.opt.expandtab = true
  table.insert(vim.opt.runtimepath, 0, "/usr/share/vim/vimfiles")
  table.insert(vim.opt.runtimepath, "/usr/share/vim/vimfiles/after")
end
