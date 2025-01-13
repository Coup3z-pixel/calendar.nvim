local date_factory = require("date")

local factory = {}

local int_to_str = function (num)
  if num == num % 10 then
    return " " .. tostring(num)
  else
    return tostring(num)
  end
end

local generate_calendar_row = function (dates)
  return {
    string.format(
    "│%s        │%s        │%s        │%s        │%s        │%s        │%s        │",
      int_to_str(dates[1]), int_to_str(dates[2]), int_to_str(dates[3]), int_to_str(dates[4]), int_to_str(dates[5]), int_to_str(dates[6]), int_to_str(dates[7])
    ),
    "│          │          │          │          │          │          │          │",
    "│          │          │          │          │          │          │          │",
    "│          │          │          │          │          │          │          │",
    "├──────────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤"
  }
end

factory.generate_calendar = function ()
  local calendar_dates = date_factory.generate_month()

  local calendar = {
    "┌────────────────────────────────────────────────────────────────────────────┐",
    "│  Sunday  │  Monday  │ Tuesday  │Wednesday │ Thursday │  Friday  │ Saturday │",
    "├──────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┤",
  }

  for i = 1, 6, 1 do
    local curr_row = generate_calendar_row(calendar_dates[i])

    for j = 1, 5, 1 do
      calendar[3+(i-1)*5+j] = curr_row[j]
    end
  end

  return calendar
end



return factory
