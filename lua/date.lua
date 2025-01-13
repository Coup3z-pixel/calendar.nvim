local date_factory = {}

function date_factory.generate_month()
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

  -- last days of prev month
  for j = first_day_of_the_week, 0, -1 do
    calendar_dates[1][j] = last_day_of_the_month - first_day_of_the_week + j
  end

  -- first days of curr month
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

  return calendar_dates
end

return date_factory
