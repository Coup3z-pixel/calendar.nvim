local M = {}

local file_manager = require("file")
local wm = require("window")
local view_factory = require("view")

local start_calendar = function ()  local win_height = 33
  local calendar_width = 72

  local float_calendar = wm.create_window("Calendar", {
    width = calendar_width,
    col = math.floor((vim.o.columns - calendar_width) / 4),
    row = math.floor((vim.o.lines - win_height) / 3),
    height = win_height
  })

  local info_width = 32

  local float_info = wm.create_window("Date Info", {
    width = info_width,
    col = math.floor((vim.o.columns - calendar_width) / 4) + calendar_width + 5,
    row = math.floor((vim.o.lines - win_height) / 3),
    height = win_height
  })

  vim.api.nvim_buf_set_lines(float_calendar.buf, 0, -1, false, view_factory.generate_calendar())
  vim.api.nvim_buf_set_lines(float_info.buf, 0, -1, false, {})
  vim.api.nvim_buf_call(float_info.buf, function ()
    local curr_date = string.format("%s.%s.%s.md", os.date("%d"), os.date("%m"), os.date("%Y"))
    file_manager.ensure_file_exists(curr_date)
    vim.cmd("silent! edit " .. curr_date)
  end)
end

M.setup = function ()
  vim.keymap.set("n", "<C-g>", start_calendar)
end

return M
