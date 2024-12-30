return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.statusline').setup { use_icons = true }
      require('mini.jump').setup {}
      require('mini.ai').setup {}
      require('mini.surround').setup {}
    end
  }
}
