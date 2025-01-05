return {
  { "folke/tokyonight.nvim",
    opts = { style = "moon" } },
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
