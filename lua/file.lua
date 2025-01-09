local manager = {}

PrewriteDate = "# 12am \n # 1am \n # 2am \n # 3am \n # 4am \n # 5am \n # 6am \n # 7am \n # 8am \n # 9am \n # 10am \n # 11am \n # 12pm \n # 1pm \n # 2pm \n # 3pm \n # 4pm \n # 5pm \n # 6pm \n # 7pm \n # 8pm \n # 9pm \n # 10pm \n # 11pm \n"

function manager.file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function manager.prewrite_date(file)
  local f = io.open("./journal/" .. file, "w")
  f:write(PrewriteDate)
  f:close()
end

--- Check if a file or directory exists in this path
function manager.exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

function manager.ensure_jounral_dir()
  os.execute("mkdir journal")
end

return manager
