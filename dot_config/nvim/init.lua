vim.g.mapleader = '<space>'

vim.loader.enable()

require('config.environment')
require('config.lazy')
require('config.options')
require('config.diagnostics')
require('config.keymaps')
require('config.floterminal')
require('config.terminal')
require('config.python')

require('config.arista')
