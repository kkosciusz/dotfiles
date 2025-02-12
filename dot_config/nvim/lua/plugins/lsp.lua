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
      { -- optional blink completion source for require statements and module annotations
        "saghen/blink.cmp",
        opts = {
          sources = {
            -- add lazydev to your completion providers
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
              },
            },
          },
        },
      },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require "lspconfig"
      -- Lua LSP
      lsp.lua_ls.setup { capabilities = capabilities }

      -- Python LSP
      --[[
      local virtualenv = vim.env.VIRTUAL_ENV
      local pylsp_mypy = { enabled = true }
      if virtualenv ~= nil then
        pylsp_mypy["overrides"] = {
          true, "--python-executable", vim.env.VIRTUAL_ENV .. "/bin/python"
        }
      end
      lsp.pylsp.setup {
        -- cmd = vim.lsp.rpc.connect("127.0.0.1", 9977),
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              -- disabled
              autopep8 = { enabled = false },
              flake8 = { enabled = false },
              mccabe = { enabled = false },
              pyflakes = { enabled = false },
              pylint = { enabled = false },
              pycodestyle = { enabled = false },
              pydocstyle = { enabled = false },
              -- enabled
              pylsp_mypy = pylsp_mypy,
              rope_autoimport = { enabled = true },
              rope_completion = { enabled = true },
              yapf = { enabled = true },
            }
          }
        }
      }
      --]]
      lsp.basedpyright.setup {
        capabilities = capabilities,
        settings = {
          basedpyright = {
            typeCheckingMode = "standard",
            analysis = {
              diagnosticMode = "openFilesOnly",
            }
          }
        }
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            local buf = args.buf
            vim.bo[buf].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:500})'
          end
        end,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded", }
      )
    end,
  }
}
