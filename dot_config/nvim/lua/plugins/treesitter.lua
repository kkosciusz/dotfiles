return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "go",
        "html",
        "ini",
        "javascript",
        "jq",
        "json",
        "lua",
        "make",
        "markdown",
        "python",
        "tmux",
        "toml",
        "vim",
        "yaml",
      },
      auto_install = false,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      },
    },
    config = function(_, opts)
      require "nvim-treesitter.configs".setup(opts)
    end
  }
}
