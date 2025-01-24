return {
  {
    'aaronik/treewalker.nvim',
    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      highlight = true,
      highlight_duration = 250,
      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = 'CursorLine',
    },
    config = function()
      -- movement
      vim.keymap.set({ 'n', 'v' }, '<c-k>', '<cmd>Treewalker Up<cr>', { silent = true })
      vim.keymap.set({ 'n', 'v' }, '<c-j>', '<cmd>Treewalker Down<cr>', { silent = true })
      vim.keymap.set({ 'n', 'v' }, '<c-h>', '<cmd>Treewalker Left<cr>', { silent = true })
      vim.keymap.set({ 'n', 'v' }, '<c-l>', '<cmd>Treewalker Right<cr>', { silent = true })

      -- swapping
      vim.keymap.set('n', '<sc-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
      vim.keymap.set('n', '<sc-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
      vim.keymap.set('n', '<sc-h>', '<cmd>Treewalker SwapLeft<CR>', { silent = true })
      vim.keymap.set('n', '<sc-l>', '<cmd>Treewalker SwapRight<CR>', { silent = true })
    end,
  }
}
