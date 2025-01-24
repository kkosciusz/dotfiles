local function create_floating_term(opts)
  -- Default options
  opts = opts or {}
  local width = opts.width or 0.8
  local height = opts.height or 0.8

  -- Get editor dimensions
  local columns = vim.o.columns
  local lines = vim.o.lines
  local win_height = math.floor(lines * height)
  local win_width = math.floor(columns * width)

  -- Calculate starting position to center the window
  local row = math.floor((lines - win_height) / 2)
  local col = math.floor((columns - win_width) / 2)

  -- Create window configuration
  local win_opts = {
    relative = 'editor',
    style = 'minimal',
    border = 'rounded',
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  -- Create buffer for terminal
  local buf = vim.api.nvim_create_buf(false, true)

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Open terminal in buffer
  vim.fn.termopen(vim.o.shell, {
    on_exit = function()
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  })

  -- Enter insert mode
  vim.cmd.startinsert()

  -- Return buffer and window IDs for potential further manipulation
  return { buf = buf, win = win }
end

-- Example usage:
-- create_floating_term()  -- Uses default size (80% of screen)
-- create_floating_term({ width = 0.5, height = 0.6 })  -- Custom size

vim.keymap.set('n', '<space>tt', create_floating_term)
