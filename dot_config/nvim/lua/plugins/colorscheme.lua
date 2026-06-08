return {
  { "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      styles = {
        comments = {},
        -- apparently empty does not change anything
        keywords = {},
        functions = {},
        variables = {},
      },
      on_colors = function(c)
        -- c.orange = "#ff0000"
      end,
      on_highlights = function(hl, c)
        hl.Comment                   = { fg = c.teal }
        hl.Delimiter                 = "Normal"
        hl.Macro                     = "Normal"
        hl.Conditional               = "Normal"
        hl.Special                   = "Normal"
        hl.Define                    = "Normal"
        hl.Exception                 = "Normal"
        hl.Type                      = "Normal"
        hl.Typedef                   = "Normal"
        hl.PreProc                   = "Normal"
        hl.Include                   = "Normal"
        hl.Statement                 = "Normal"
        hl.Operator                  = { fg = c.fg_dark }
        hl.Keyword.fg                = c.fg
        hl["@string.documentation"]  = "Comment"
        hl["@boolean"]               = "Constant"
        hl["@label"]                 = "Normal"
        hl["@operator"]              = "Operator"
        hl["@constructor"]           = "Operator"
        hl["@property"]              = "Normal"
        hl["@punctuation.delimiter"] = "Operator"
        hl["@punctuation.special"]   = "Operator"
        hl["@function.call"]         = "Normal"
        hl["@function.method.call"]  = "Normal"
        hl["@type.definition"]       = "Function"
        hl["@type.builtin"]          = "Normal"
        hl["@module"]                = "Normal"
        hl["@module.builtin"]        = "Normal"
        hl["@variable"]              = "Normal"
        hl["@variable.builtin"]      = "Parameter"
        hl["@variable.member"]       = "Normal"
        for k, _ in pairs(hl) do
          if string.find(k, "@keyword") == 1 then
            hl[k] = "Normal"
          end
        end
        hl["@keyword.coroutine"]     = { fg = c.purple }
      end,
    }
  },
  { "sainnhe/gruvbox-material", event = "User LazyColorscheme",
    config = function()
      vim.g.gruvbox_material_background = 'hard' -- 'soft', 'medium', 'hard'
      vim.g.gruvbox_material_foreground = 'original' -- 'material', 'mix', 'original'
      vim.g.gruvbox_material_enable_italic = true
    end
  },
  { "AlexvZyl/nordic.nvim", event = "User LazyColorscheme" },
  { "rebelot/kanagawa.nvim", event = "User LazyColorscheme" },
  { "Mofiqul/vscode.nvim", event = "User LazyColorscheme" },
  { "catppuccin/nvim", event = "User LazyColorscheme" },
}
