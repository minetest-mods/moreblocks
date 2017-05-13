--[[
More Blocks: Stairs+

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Nodes will be called <modname>:{stair,slab,panel,micro}_<subname>

local modpath = minetest.get_modpath("moreblocks").. "/stairsplus"

stairsplus = {}
stairsplus.expect_infinite_stacks = false

stairsplus.shapes_list = {}

if not minetest.get_modpath("unified_inventory")
and minetest.settings:get_bool("creative_mode") then
	stairsplus.expect_infinite_stacks = true
end

function stairsplus.copytable(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[stairsplus.copytable(orig_key)] = stairsplus.copytable(orig_value)
		end
		setmetatable(copy, stairsplus.copytable(getmetatable(orig)))
	else
		copy = orig
	end
	return copy
end

function stairsplus:prepare_groups(groups)
	local result = {}
	if groups then
		for k, v in pairs(groups) do
			if k ~= "wood" and k ~= "stone" then
				result[k] = v
			end
		end
	end
	if not moreblocks.config.stairsplus_in_creative_inventory then
		result.not_in_creative_inventory = 1
	end
	return result
end

function stairsplus:register_all(modname, subname, recipeitem, fields)
	self:register_stair(modname, subname, recipeitem, fields)
	self:register_slab (modname, subname, recipeitem, fields)
	self:register_slope(modname, subname, recipeitem, fields)
	self:register_panel(modname, subname, recipeitem, fields)
	self:register_micro(modname, subname, recipeitem, fields)
	-- self:register_6dfacedir_conversion(modname, subname) -- Not needed as of Q3 2013, uncomment to fix old maps.
end

function stairsplus:register_alias_all(modname_old, subname_old, modname_new, subname_new)
	self:register_stair_alias(modname_old, subname_old, modname_new, subname_new)
	self:register_slab_alias(modname_old, subname_old, modname_new, subname_new)
	self:register_slope_alias(modname_old, subname_old, modname_new, subname_new)
	self:register_panel_alias(modname_old, subname_old, modname_new, subname_new)
	self:register_micro_alias(modname_old, subname_old, modname_new, subname_new)
end
function stairsplus:register_alias_force_all(modname_old, subname_old, modname_new, subname_new)
	self:register_stair_alias_force(modname_old, subname_old, modname_new, subname_new)
	self:register_slab_alias_force(modname_old, subname_old, modname_new, subname_new)
	self:register_slope_alias_force(modname_old, subname_old, modname_new, subname_new)
	self:register_panel_alias_force(modname_old, subname_old, modname_new, subname_new)
	self:register_micro_alias_force(modname_old, subname_old, modname_new, subname_new)
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
