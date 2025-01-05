-- pick colorscheme from all installed ones
local telescope = require("telescope.builtin")
local function colorscheme_picker()
  vim.cmd("doautocmd User LazyColorscheme")
  telescope.colorscheme({ enable_preview = true, ignore_builtin = true })
end
vim.keymap.set("n", "<space>uc", colorscheme_picker, { desc = "Colorscheme with preview" })
