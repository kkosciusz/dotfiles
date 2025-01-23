return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup {}
      require('mini.cursorword').setup {}
      require('mini.indentscope').setup {}
      require('mini.jump').setup {}
      require('mini.pairs').setup {}
      require('mini.statusline').setup { use_icons = true }
      require('mini.surround').setup {}
      require('mini.tabline').setup {}
      require('mini.trailspace').setup {}
    end
  }
}
