--[[
=====================================================================
** More Blocks **
By Calinou, with the help of ShadowNinja and VanessaE.

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
=====================================================================
--]]

moreblocks = {}

local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
moreblocks.intllib = S

local modpath = minetest.get_modpath("moreblocks")

dofile(modpath .. "/config.lua")
dofile(modpath .. "/circular_saw.lua")
dofile(modpath .. "/stairsplus/init.lua")
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/redefinitions.lua")
dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/aliases.lua")

if minetest.setting_getbool("log_mods") then
	minetest.log("action", S("[moreblocks] loaded."))
end
