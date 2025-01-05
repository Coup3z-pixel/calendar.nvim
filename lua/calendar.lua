local M = {}

local file_manager = require("file")
local wm = require("window")
local view_factory = require("view")

local start_calendar = function ()
  local window_height = 33
  local calendar_width = 76

  local calendar_window = wm.create_window("Calendar", {
    width = calendar_width,
    height = window_height,
    col = math.floor((vim.o.columns - calendar_width) / 5),
    row = math.floor((vim.o.lines - window_height) / 3)
  })

  local info_width = 50

  local info_window = wm.create_window("Date Info", {
    width = info_width,
    height = window_height,
    col = math.floor((vim.o.columns - calendar_width) / 5) + calendar_width + 5,
    row = math.floor((vim.o.lines - window_height) / 3)
  })

  vim.api.nvim_buf_set_lines(calendar_window.buf, 0, -1, false, view_factory.generate_calendar())
  vim.api.nvim_buf_set_lines(info_window.buf, 0, -1, false, {})
  vim.api.nvim_buf_call(info_window.buf, function ()
    local curr_date = string.format("%s.%s.%s.md", os.date("%d"), os.date("%m"), os.date("%Y"))
    if file_manager.file_exists("./journal/" .. curr_date) then
      file_manager.prewrite_date()
    end
    file_manager.file_exists("./journal/" .. curr_date)
    vim.cmd("silent! edit " .. "./journal/" .. curr_date)
  end)
end

M.setup = function ()

  -- User Commands
  vim.api.nvim_create_user_command('ShowCalendar', start_calendar, {})

  -- Keybinds
  vim.keymap.set("n", "<C-g>", start_calendar)
end

return M
