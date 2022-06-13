--[[
More Blocks: Stairs+

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Nodes will be called <modname>:{stair,slab,panel,micro,slope}_<subname>
local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

stairsplus = {
	version = {3, 0, 0},
	fork = "minetest_mods",

	modname = modname,
	modpath = modpath,

	S = S,

	has = {
		basic_materials = minetest.get_modpath("basic_materials"),
		default = minetest.get_modpath("default"),
		gloopblocks = minetest.get_modpath("gloopblocks"),
		stairs = minetest.get_modpath("stairs"),
		technic = minetest.get_modpath("technic"),
		prefab = minetest.get_modpath("prefab"),
		wool = minetest.get_modpath("wool"),
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

stairsplus.shapes_list = {}


function stairsplus:prepare_groups(groups)
	local result = {}
	if groups then
		for k, v in pairs(groups) do
			if k ~= "wood" and k ~= "stone" and k ~= "wool" and k ~= "tree" then
				result[k] = v
			end
		end
	end

	if not stairsplus.settings.in_creative_inventory then
		result.not_in_creative_inventory = 1
	end

	return result
end

function stairsplus:register_all(modname, subname, recipeitem, fields)
	self:register_stair(modname, subname, recipeitem, fields)
	self:register_slab(modname, subname, recipeitem, fields)
	self:register_slope(modname, subname, recipeitem, fields)
	self:register_panel(modname, subname, recipeitem, fields)
	self:register_micro(modname, subname, recipeitem, fields)
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

local function register_stair_slab_panel_micro(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_all(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light
	})
end

dofile(modpath .. "/defs.lua")
dofile(modpath .. "/recipes.lua")
dofile(modpath .. "/common.lua")
dofile(modpath .. "/stairs.lua")
dofile(modpath .. "/slabs.lua")
dofile(modpath .. "/slopes.lua")
dofile(modpath .. "/panels.lua")
dofile(modpath .. "/microblocks.lua")
dofile(modpath .. "/custom.lua")
dofile(modpath .. "/registrations.lua")
