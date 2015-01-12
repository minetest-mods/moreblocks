--[[
More Blocks: Stairs+

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Nodes will be called <modname>:{stair,slab,panel,micro}_<subname>

local modpath = minetest.get_modpath("moreblocks").. "/stairsplus"

stairsplus = {}
stairsplus.expect_infinite_stacks = false

if not minetest.get_modpath("unified_inventory")
and minetest.setting_getbool("creative_mode") then
	stairsplus.expect_infinite_stacks = true
end

function stairsplus:register_all(modname, subname, recipeitem, fields)
	fields = fields or {}
	fields.groups = fields.groups or {}
	if not moreblocks.config.stairsplus_in_creative_inventory then
		fields.groups.not_in_creative_inventory = 1
	end
	self:register_stair(modname, subname, recipeitem, fields)
	self:register_slab (modname, subname, recipeitem, fields)
	self:register_slope(modname, subname, recipeitem, fields)
	self:register_panel(modname, subname, recipeitem, fields)
	self:register_micro(modname, subname, recipeitem, fields)
	-- self:register_6dfacedir_conversion(modname, subname) -- Not needed as of Q3 2013, uncomment to fix old maps.
	circular_saw.known_nodes[recipeitem] = {modname, subname}
end

function register_stair_slab_panel_micro(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_all(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light
	})
end

-- dofile(modpath.. "/aliases.lua") -- Not needed as of Q2 2013, uncomment to fix old maps.
-- dofile(modpath.. "/conversion.lua") -- Not needed as of Q2 2013, uncomment to fix old maps.
dofile(modpath .. "/stairs.lua")
dofile(modpath .. "/slabs.lua")
dofile(modpath .. "/slopes.lua")
dofile(modpath .. "/panels.lua")
dofile(modpath .. "/microblocks.lua")
dofile(modpath .. "/registrations.lua")
