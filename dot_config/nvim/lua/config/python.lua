local function format_visual_selection(formatter_cmd)
  -- Get the current buffer number and filename
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  -- Check if file has been saved (has a filename)
  if filename == "" then
    vim.notify("Buffer has no filename. Save the file first.", vim.log.levels.ERROR)
    return
  end

  -- Get visual selection range
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Validate the range
  if start_line == 0 or end_line == 0 then
    vim.notify("No visual selection found", vim.log.levels.ERROR)
    return
  end

  -- Build the formatter command with line range
  local cmd = string.format("%s -i --lines %d-%d %s", formatter_cmd, start_line, end_line, vim.fn.shellescape(filename))

  -- Run the formatter
  local result = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    vim.notify("Formatter failed: " .. result, vim.log.levels.ERROR)
    return
  end

  -- Reload the buffer to show the changes
  vim.cmd("checktime")

  vim.notify("Selection formatted successfully", vim.log.levels.INFO)
end

-- Convenience function specifically for yapf
local function format_python_selection()
  format_visual_selection("yapf")
end

-- Create user commands
vim.api.nvim_create_user_command("PythonFormatSelection", function()
  format_python_selection()
end, {
    desc = "Format visual selection with yapf"
  })

return {
  format_visual_selection = format_visual_selection,
  format_python_selection = format_python_selection
}
