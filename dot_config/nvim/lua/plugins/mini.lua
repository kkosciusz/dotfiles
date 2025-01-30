return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('config.environment')
      require('mini.ai').setup {}
      require('mini.cursorword').setup {}
      require('mini.indentscope').setup {}
      require('mini.jump').setup {}
      require('mini.pairs').setup {}
      require('mini.statusline').setup {
        -- see https://github.com/mobile-shell/mosh/issues/1281#issuecomment-2292604969
        use_icons = not Env.is_connected_via_mosh
      }
      require('mini.surround').setup {}
      -- Shows all buffers as tabs, rather mouse oriented?
      -- require('mini.tabline').setup { set_vim_settings = false }
      require('mini.trailspace').setup {}
      require('mini.align').setup {}
    end
  }
}
