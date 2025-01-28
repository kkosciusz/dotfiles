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
vim.keymap.set('n', '<space>d', function ()
  vim.diagnostic.open_float {
    scope = 'line',
    header = "",
    border = "rounded",
    source = "if_many",
    prefix = "",
  }
end)

-- Currently unused
local format_range_operator = function()
  -- example how to implement an operator that works on motion
  local old_func = vim.go.operatorfunc
  -- set a globally callable object/function
  _G.op_func_formatting = function(mode)
    local left = vim.api.nvim_buf_get_mark(0, '[')
    local right = vim.api.nvim_buf_get_mark(0, ']')

    local args = { range = { start = left, ['end'] = right } }
    vim.print { mode = mode, args = args }
    vim.lsp.buf.format(args)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil -- deletes itself from global namespace
  end
  vim.opt.operatorfunc = 'v:lua.op_func_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end
