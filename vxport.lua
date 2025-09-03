
-- FUNCTIONS

local function vxport(fpath_str)
  print("hi there smexy!" .. fpath_str)
end


-- MODULE

local M = {}

function M.export(fpath_str)
  vxport(fpath_str)
end

return M
