return {
  {
    'dgagn/diagflow.nvim',
    opts = {
      max_width = 60,
      max_height = 3,
      scope = 'line',
      text_align = 'left',
      placement = 'inline',
      inline_padding_left = 0,
      severity_colors = {
        error = "DiagnosticVirtualTextError",
        warn = "DiagnosticVirtualTextWarn",
        info = "DiagnosticVirtualTextInfo",
        hint = "DiagnosticVirtualTextHint",
      },
    },
  }
}
