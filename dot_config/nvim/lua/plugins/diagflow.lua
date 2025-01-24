return {
  {
    'dgagn/diagflow.nvim',
    opts = {
      scope = 'line',
      text_align = 'left',
      placement = 'inline',
      inline_padding_left = 2,
      severity_colors = {
        error = "DiagnosticVirtualTextError",
        warn = "DiagnosticVirtualTextWarn",
        info = "DiagnosticVirtualTextInfo",
        hint = "DiagnosticVirtualTextHint",
      },
    },
  }
}
