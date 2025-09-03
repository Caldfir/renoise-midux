
-- FUNCTIONS

local function vxport()
  print("hi there smexy!")
end


-- MODULE

local M = {}

function M.export() vxport() end

return M
