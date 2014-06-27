--[[
-- More Blocks (moreblocks) by Calinou
-- Licensed under the zlib/ license for code and CC BY-SA 3.0 for textures, see LICENSE.txt for info.
--]]

moreblocks = {}

-- Load translation library if intllib is installed

local S -- Load translation library if intllib is installed:
if intllib then
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function(s) return s end
end
moreblocks.gettext = S

local modpath = minetest.get_modpath("moreblocks")

dofile(modpath .. "/config.lua")
dofile(modpath .. "/circular_saw.lua")
dofile(modpath .. "/stairsplus/init.lua")
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/redefinitions.lua")
dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/aliases.lua")

if minetest.setting_getbool("log_mods") then
	print(S("[moreblocks] loaded."))
end

