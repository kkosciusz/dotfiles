-- default editing options
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- display
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.cursorline = true
vim.o.conceallevel = 1
vim.o.listchars = "nbsp:⎵,tab:▸·"
vim.o.list = true

-- cursorline only in one buffer, disable in insert mode
vim.api.nvim_create_autocmd({ 'InsertLeave', 'InsertEnter', 'WinEnter', 'WinLeave' }, {
  desc = "cursor line only in normal mode in current window",
  callback = function(arg)
    local val = arg.event == 'InsertLeave' or arg.event == 'WinEnter'
    vim.wo.cursorline = val
  end,
})

-- search
vim.o.wrapscan = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- windows
vim.o.splitbelow = true
vim.o.splitright = true

-- cursor
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait100-blinkoff250-blinkon250"

-- os-specific
if Env.is_os_windows then
  vim.o.shell = "powershell -nologo"
end

-- colors
vim.o.background = 'dark'
vim.cmd('colorscheme tokyonight')
