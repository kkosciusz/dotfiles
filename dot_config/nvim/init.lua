vim.g.mapleader = '<space>'

vim.loader.enable()

require('config.lazy')
require('config.options')
require('config.diagnostics')
require('config.keymaps')
require('config.floterminal')
require('config.terminal')

require('config.arista')
