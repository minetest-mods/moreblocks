--[[
=====================================================================
** More Blocks **
By Calinou, with the help of ShadowNinja and VanessaE.

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
=====================================================================
--]]

moreblocks = {}

local S
if minetest.global_exists("intllib") then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end
moreblocks.intllib = S

local modpath = minetest.get_modpath("moreblocks")

function moreblocks.check_protection(pos, name, tool, text)
	if minetest.is_protected(pos, name) then
		minetest.log("action", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a " .. (tool or ""))
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

dofile(modpath .. "/config.lua")
dofile(modpath .. "/circular_saw.lua")
dofile(modpath .. "/stairsplus/init.lua")
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/redefinitions.lua")
dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/aliases.lua")
dofile(modpath .. "/sweeper.lua")

if minetest.settings:get_bool("log_mods") then
	minetest.log("action", S("[moreblocks] loaded."))
end
