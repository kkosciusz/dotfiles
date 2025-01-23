return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      { "saghen/blink.cmp" },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require "lspconfig"
      -- Lua LSP
      lsp.lua_ls.setup { capabilities = capabilities }
      -- Python LSP
      local virtualenv = vim.env.VIRTUAL_ENV
      local pylsp_mypy = { enabled = true }

      if virtualenv ~= nil then
        pylsp_mypy["overrides"] = {
          true, "--python-executable", vim.env.VIRTUAL_ENV .. "/bin/python"
        }
      end

      lsp.pylsp.setup {
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              pylsp_mypy = pylsp_mypy,
              autopep8 = { enabled = false },
              flake8 = { enabled = false },
              mccabe = { enabled = false },
              pyflakes = { enabled = false },
              pylint = { enabled = false },
              pycodestyle = { enabled = false },
              pydocstyle = { enabled = false },
              rope_autoimport = { enabled = true },
              yapf = { enabled = false },
            }
          }
        }
      }
      -- lsp.pyright.setup { capabilities = capabilities }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })

      vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
      vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action)
      vim.keymap.set('n', 'grr', vim.lsp.buf.references)
      vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  }
}
