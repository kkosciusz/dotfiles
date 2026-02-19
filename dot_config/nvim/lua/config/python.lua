local function format_python_range(start_line, end_line)
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if filename == "" then
    vim.notify("Buffer has no filename. Save the file first.", vim.log.levels.ERROR)
    return
  end

  if vim.api.nvim_get_option_value("modified", {buf = bufnr}) then
    vim.cmd.write()
  end

  if start_line == 0 or end_line == 0 or start_line > end_line then
    vim.notify("Invalid line range", vim.log.levels.ERROR)
    return
  end

  local cmd = string.format("yapf -i --lines %d-%d %s", start_line, end_line, vim.fn.shellescape(filename))

  local result = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    vim.notify("Formatter failed: " .. result, vim.log.levels.ERROR)
    return
  end

  -- Reload the buffer
  vim.cmd.checktime()

  vim.notify("Selection formatted successfully", vim.log.levels.INFO)
end

local function format_python_selection()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  if start_line == 0 or end_line == 0 then
    vim.notify("No visual selection found", vim.log.levels.ERROR)
    return
  end

  format_python_range(start_line, end_line)
end

vim.api.nvim_create_user_command("PythonFormatSelection", function(opts)
  if opts.range > 0 then
    format_python_range(opts.line1, opts.line2)
  else
    format_python_selection()
  end
end, {
  desc = "Format visual selection with yapf",
  range = true
})

return {
  format_python_selection = format_python_selection,
  format_python_range = format_python_range,
}
