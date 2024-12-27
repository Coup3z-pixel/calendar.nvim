local manager = {}

function manager.ensure_file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

return manager
