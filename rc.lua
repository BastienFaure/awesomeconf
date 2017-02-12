-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
vicious = require("vicious")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
menubar = require("menubar")
hotkeys_popup = require("awful.hotkeys_popup").widget

-- Load Debian menu entries
require("debian.menu")


-- {{{ Simple function to load additional LUA files from rc/.
function loadrc(name, mod)
   local success
   local result

   -- Which file? In rc/ or in lib/?
   local path = awful.util.getdir("config") .. "/" ..
      (mod and "lib" or "rc") ..
      "/" .. name .. ".lua"

   -- If the module is already loaded, don't load it again
   if mod and package.loaded[mod] then return package.loaded[mod] end

   -- Execute the RC/module file
   success, result = pcall(function() return dofile(path) end)
   if not success then
      naughty.notify({ title = "Error while loading an RC file",
               text = "When loading `" .. name ..
              "`, got the following error:\n" .. result,
               preset = naughty.config.presets.critical
             })
      return print("E: error loading RC file '" .. name .. "': " .. result)
   end

   -- Is it a module?
   if mod then
      return package.loaded[mod]
   end

   return result
end
-- }}}

loadrc("helpers")
loadrc("errors")
loadrc("vars")
loadrc("menu")

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

loadrc("widgets")
loadrc("bindings")
loadrc("rules")
loadrc("signals")
