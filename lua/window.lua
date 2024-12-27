local manager = {}

Height = 33

function manager.create_window(name, dimension)

  local buf = vim.api.nvim_create_buf(false, true)

  local win_config = {
    relative = "editor",
    width = dimension.width,
    height = dimension.height,
    col = dimension.col,
    row = dimension.row,
    style = "minimal",
    border = "rounded",
    title = name,
    title_pos = "center"
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

return manager
