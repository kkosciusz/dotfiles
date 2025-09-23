vim.g.mapleader = ' '

vim.loader.enable()

require('config.environment')
require('config.lazy')
require('config.options')
require('config.diagnostics')
require('config.keymaps')
require('config.floterminal')
require('config.terminal')
require('config.python')
require('config.lsp')

require('config.arista')
