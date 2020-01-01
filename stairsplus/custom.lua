--[[
More Blocks: microblock definitions

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

--[[
Subset table should have the following format: (You can remove entries as needed.)

local subset = {
	{ "micro", "" },
	{ "micro", "_1" },
	{ "micro", "_2" },
	{ "micro", "_4" },
	{ "micro", "_12" },
	{ "micro", "_14" },
	{ "micro", "_15" },
	{ "panel", "" },
	{ "panel", "_1" },
	{ "panel", "_2" },
	{ "panel", "_4" },
	{ "panel", "_12" },
	{ "panel", "_14" },
	{ "panel", "_15" },
	{ "slab",  "" },
	{ "slab",  "_quarter" },
	{ "slab",  "_three_quarter" },
	{ "slab",  "_1" },
	{ "slab",  "_2" },
	{ "slab",  "_14" },
	{ "slab",  "_15" },
	{ "slab",  "_two_sides" },
	{ "slab",  "_three_sides" },
	{ "slab",  "_three_sides_u" },
	{ "slope", "" },
	{ "slope", "_half" },
	{ "slope", "_half_raised" },
	{ "slope", "_inner" },
	{ "slope", "_inner_half" },
	{ "slope", "_inner_half_raised" },
	{ "slope", "_inner_cut" },
	{ "slope", "_inner_cut_half" },
	{ "slope", "_inner_cut_half_raised" },
	{ "slope", "_outer" },
	{ "slope", "_outer_half" },
	{ "slope", "_outer_half_raised" },
	{ "slope", "_outer_cut" },
	{ "slope", "_outer_cut_half" },
	{ "slope", "_outer_cut_half_raised" },
	{ "slope", "_cut" },
	{ "stair", "" },
	{ "stair", "_half" },
	{ "stair", "_right_half" },
	{ "stair", "_inner" },
	{ "stair", "_outer" },
	{ "stair", "_alt" },
	{ "stair", "_alt_1" },
	{ "stair", "_alt_2" },
	{ "stair", "_alt_4" },
}
--]]

-- luacheck: no unused
local function register_custom_subset(subset, modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_custom_subset(subset, modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_custom_subset_alias(subset, modname_old, subname_old, modname_new, subname_new)
	local subset_copy = table.copy(subset)
	for k, v in pairs(subset_copy) do
		minetest.register_alias(modname_old .. ":" .. v[1] .. "_" .. subname_old .. v[2], modname_new .. ":" .. v[1] .. "_" .. subname_new .. v[2])
	end
end

function stairsplus:register_custom_subset_alias_force(subset, modname_old, subname_old, modname_new, subname_new)
	local subset_copy = table.copy(subset)
	for k, v in pairs(subset_copy) do
		minetest.register_alias_force(modname_old .. ":" .. v[1] .. "_" .. subname_old .. v[2], modname_new .. ":" .. v[1] .. "_" .. subname_new .. v[2])
	end
end

function stairsplus:register_custom_subset(subset, modname, subname, recipeitem, fields)
	local subset_copy = table.copy(subset)
	for k, v in pairs(subset_copy) do
		stairsplus.register_single(v[1], v[2], stairsplus.defs[v[1]][v[2]], modname, subname, recipeitem, fields)
	end

	circular_saw.known_nodes[recipeitem] = {modname, subname}
end
