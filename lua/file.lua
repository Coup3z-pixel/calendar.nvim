
local manager = {}

function manager.file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function manager.prewrite_date()

end

return manager
