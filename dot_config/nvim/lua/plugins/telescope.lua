return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },
    extensions = {
      fzf = {},
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy",
          },
          help_tags = {
            theme = "ivy",
          },
          oldfiles = {
            theme = "ivy",
          },
        }
      }
      vim.keymap.set('n', '<space>fh', require('telescope.builtin').help_tags)
      vim.keymap.set('n', '<space>fo', require('telescope.builtin').oldfiles)
      vim.keymap.set('n', '<space>fr', function()
        require('telescope.builtin').oldfiles { cwd_only = true }
      end)
      vim.keymap.set('n', '<space>fd', function()
        require('telescope.builtin').find_files { follow = true, }
      end)
      vim.keymap.set('n', '<space>fD', function()
        require('telescope.builtin').find_files { follow = true, hidden = true, no_ignore = true, }
      end)
      vim.keymap.set('n', '<space>fb', function()
        require('telescope.builtin').buffers {}
      end)
      vim.keymap.set('n', '<space>en', function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath("config") }
      end)
      vim.keymap.set('n', '<space>ep', function()
        require('telescope.builtin').find_files { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") }
      end)
      vim.keymap.set('n', '<space>fg', require("config.telescope").live_multigrep)
      vim.keymap.set('x', '<space>fg', function()
        vim.cmd.normal("") -- need to exit visual mode to update the marks
        local start_pos = vim.fn.getcharpos("'<")
        local end_pos = vim.fn.getcharpos("'>")
        local text = vim.api.nvim_buf_get_text(
          0,
          start_pos[2] - 1,
          start_pos[3] - 1,
          end_pos[2] - 1,
          end_pos[3],
          {}
        )[1] -- first line only
        require("config.telescope").live_multigrep { default_text = text }
      end)
      vim.keymap.set('n', '<space>ec', function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath("~", ".config"),
          hidden = true,
        }
      end)
    end
  }
}
