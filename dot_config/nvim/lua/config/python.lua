local function format_python_range(start_line, end_line)
  -- Get the current buffer number and filename
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  -- Check if file has been saved (has a filename)
  if filename == "" then
    vim.notify("Buffer has no filename. Save the file first.", vim.log.levels.ERROR)
    return
  end

  -- Save the buffer if it has been modified to ensure yapf works on current content
  if vim.api.nvim_get_option_value("modified", {buf = bufnr}) then
    vim.cmd.write()
  end

  -- Validate the range
  if start_line == 0 or end_line == 0 or start_line > end_line then
    vim.notify("Invalid line range", vim.log.levels.ERROR)
    return
  end

  -- Build the formatter command with line range
  local cmd = string.format("yapf -i --lines %d-%d %s", start_line, end_line, vim.fn.shellescape(filename))

  -- Run the formatter
  local result = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    vim.notify("Formatter failed: " .. result, vim.log.levels.ERROR)
    return
  end

  -- Reload the buffer to show the changes
  vim.cmd.checktime()

  vim.notify("Selection formatted successfully", vim.log.levels.INFO)
end

local function format_python_selection()
  -- Get visual selection range
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Validate the range
  if start_line == 0 or end_line == 0 then
    vim.notify("No visual selection found", vim.log.levels.ERROR)
    return
  end

  format_python_range(start_line, end_line)
end

-- Create user commands
vim.api.nvim_create_user_command("PythonFormatSelection", function(opts)
  -- If called with a range (from visual mode), use the range
  if opts.range > 0 then
    format_python_range(opts.line1, opts.line2)
  else
    -- If called without range (from normal mode), use visual marks
    format_python_selection()
  end
end, {
  desc = "Format visual selection with yapf",
  range = true   -- Allow the command to accept a range
})

return {
  format_python_selection = format_python_selection,
  format_python_range = format_python_range,
}
