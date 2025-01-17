local M = {}

local file_manager = require("file")
local wm = require("window")
local view_factory = require("view")
local date_factory = require("date")

function M.start_calendar()
  if not file_manager.exists("journal/") then
    file_manager.ensure_jounral_dir()
  end

  local curr_date = string.format("%s.%s.%s.md", os.date("%d"), os.date("%m"), os.date("%Y"))

  if not file_manager.file_exists("./journal/" .. curr_date) then
    file_manager.prewrite_date(curr_date)
  end

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
    vim.cmd("silent! edit " .. "./journal/" .. curr_date)
  end)

  vim.api.nvim_buf_set_keymap(calendar_window.buf, 'n', '<CR>', ":lua Change_info_buf()<CR>", { noremap = true, silent = true })

  M["info_buf"] = info_window.buf
end

function Change_info_buf()
  local info_buf = M["info_buf"]
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local y, x = cursor_pos[1], cursor_pos[2]

  local month = date_factory.generate_month()



  if math.fmod(x, 11) == 0 then
    return
  end

  -- Associating cords to a date
  local weekIndex = math.floor((y / 11)+0.5)
  local dayIndex =math.floor((x / 12)+0.5)

  -- TODO check for last month
  local date = string.format("%s.%s.%s.md", month[weekIndex][dayIndex], os.date("%m"), os.date("%Y"))

  if not file_manager.file_exists("./journal/" .. date) then
    file_manager.prewrite_date(date)
  end

  vim.api.nvim_buf_call(info_buf, function ()
    vim.cmd("silent! edit " .. "./journal/" .. date)
  end)
end

M.setup = function ()

  -- User Commands
  vim.api.nvim_create_user_command('ShowCalendar', M.start_calendar, {})

  --[[
  --  TODO date interactive
  --  TODO week view
  --]]

  -- Keybinds
  vim.keymap.set("n", "<C-g>", M.start_calendar)
end

return M
