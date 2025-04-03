local config =  {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    }
  },
}

if vim.version.ge( vim.version(), {0, 11, 0} ) then
    config['virtual_lines'] = { current_line = true }
end

vim.diagnostic.config (config)

-- From help: diagnostic-handlers-example
-- local ns = vim.api.nvim_create_namespace("my_namespace")
-- local orig_signs_handler = vim.diagnostic.handlers.signs
-- vim.diagnostic.handlers.signs = {
--   show = function(_, bufnr, _, opts)
--     local diagnostics = vim.diagnostic.get(bufnr)
--
--     local max_severity_per_line = {}
--     for _, d in pairs(diagnostics) do
--       local m = max_severity_per_line[d.lnum]
--       if not m or d.severity < m.severity then
--         max_severity_per_line[d.lnum] = d
--       end
--     end
--
--     local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
--     orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
--   end,
--   hide = function(_, bufnr)
--     orig_signs_handler.hide(ns, bufnr)
--   end,
-- }
