--[[============================================================================
main.lua
============================================================================]]--

_AUTO_RELOAD_DEBUG = function()
  -- do tests like showing a dialog, prompts whatever, or simply do nothing
end

print("Hello world!!")

-- FUNCTIONS

 function vxport()
   print("hi")
 end


-- BINDINGS

 renoise.tool():add_menu_entry {
   name = "Main Menu:File:MiDu MIDI export ",
   invoke = vxport
 }
