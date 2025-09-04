
local VX = require "vxport"

_AUTO_RELOAD_DEBUG = function()
  -- do tests like showing a dialog, prompts whatever, or simply do nothing
end

print("loaded midu")


-- FUNCTIONS

 local function vxport()
  local fpath_str = "derp.mid"--renoise.app():prompt_for_filename_to_write("mid", "Export MIDI")
  if fpath_str == "" then return end
  VX:export(fpath_str)
 end


-- BINDINGS

 renoise.tool():add_menu_entry {
   name = "Main Menu:File:MiDu MIDI export",
   invoke = vxport
 }
