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
    "│%s        │%s        │%s       │%s       │%s        │%s        │%s        │",
      int_to_str(dates[1]), int_to_str(dates[2]), int_to_str(dates[3]), int_to_str(dates[4]), int_to_str(dates[5]), int_to_str(dates[6]), int_to_str(dates[7])
    ),
    "│          │          │         │         │          │          │          │",
    "│          │          │         │         │          │          │          │",
    "│          │          │         │         │          │          │          │",
    "├──────────┼──────────┼─────────┼─────────┼──────────┼──────────┼──────────┤"
  }
end

factory.generate_calendar = function ()
  local calendar_dates = {}

  for i = 1, 6, 1 do
    calendar_dates[i] = {}

    for j = 1, 7, 1 do
      calendar_dates[i][j] = 0
    end
  end

  -- Get the current year and month
  local year = os.date("%Y") -- Current year
  local month = os.date("%m") -- Current month

  -- Construct a table representing the first day of the month
  local first_day = {
      year = year,
      month = month,
      day = 1,
      hour = 0,
      min = 0,
      sec = 0,
  }

  local next_month = {
    year = year,
    month = month + 1,
    day = 1,
    hour = 0,
    min = 0,
    sec = 0
  }

  local first_day_timestamp = os.time(first_day)
  local first_day_of_the_week = tonumber(os.date("%w", first_day_timestamp))

  local last_day_timestamp = first_day_timestamp - 86400
  local last_day_of_the_month = tonumber(os.date("%d", last_day_timestamp))

  for j = first_day_of_the_week, 0, -1 do
    calendar_dates[1][j] = last_day_of_the_month - first_day_of_the_week + j
  end

  for j = first_day_of_the_week+1, 7, 1 do
    calendar_dates[1][j] = j - first_day_of_the_week
  end

  for i = 2, 6, 1 do
    for j = 1, 7, 1 do
      if (7-first_day_of_the_week+1)+(i-2)*7+j-1 <= tonumber(os.date("%d", os.time(next_month) - 86400)) then
        calendar_dates[i][j] = (7-first_day_of_the_week+1)+(i-2)*7+j-1
      else
        calendar_dates[i][j] = (7-first_day_of_the_week+1)+(i-2)*7+j-1 - tonumber(os.date("%d", os.time(next_month) - 86400))
      end
    end
  end

  local calendar = {
    "┌──────────────────────────────────────────────────────────────────────────┐",
    "│  Sunday  │  Monday  │ Tuesday │Wednesday│ Thursday │  Friday  │ Saturday │",
    "├──────────┬──────────┬─────────┬─────────┬──────────┬──────────┬──────────┤",
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
