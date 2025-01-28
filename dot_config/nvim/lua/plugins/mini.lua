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
      -- Shows all buffers as tabs, rather mouse oriented?
      -- require('mini.tabline').setup { set_vim_settings = false }
      require('mini.trailspace').setup {}
      require('mini.align').setup {}
    end
  }
}
