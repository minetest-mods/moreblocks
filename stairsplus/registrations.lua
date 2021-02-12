--[[
More Blocks: registrations

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- default registrations
local default_nodes = { -- Default stairs/slabs/panels/microblocks:
	"acacia_tree",
	"acacia_wood",
	"aspen_tree",
	"aspen_wood",
	"bookshelf",
	"brick",
	"bronzeblock",
	"cave_ice",
	--"clay",
	"coalblock",
	"cobble",
	"copperblock",
	"coral_brown",
	"coral_cyan",
	"coral_green",
	"coral_orange",
	"coral_pink",
	"coral_skeleton",
	"desert_cobble",
	"desert_sand",
	"desert_sandstone_block",
	"desert_sandstone_brick",
	"desert_sandstone",
	"desert_stone_block",
	"desert_stone",
	"desert_stonebrick",
	"diamondblock",
	--"dirt_with_coniferous_litter",
	--"dirt_with_dry_grass",
	--"dirt_with_grass_footsteps",
	--"dirt_with_grass",
	--"dirt_with_rainforest_litter",
	--"dirt_with_snow",
	--"dirt",
	--"dry_dirt_with_dry_grass",
	--"dry_dirt",
	"glass",
	"goldblock",
	--"gravel",
	"ice",
	"jungletree",
	"junglewood",
	"mese",
	"meselamp",
	"mossycobble",
	"obsidian_block",
	"obsidian_glass",
	"obsidian",
	"obsidianbrick",
	--"permafrost_with_moss",
	--"permafrost_with_stones",
	--"permafrost",
	"pine_bush_needles",
	"pine_tree",
	"pine_wood",
	--"sand",
	"sandstone_block",
	"sandstone",
	"sandstonebrick",
	--"silver_sand",
	"silver_sandstone_block",
	"silver_sandstone_brick",
	"silver_sandstone",
	"snowblock",
	"steelblock",
	"stone_block",
	--"stone_with_coal",
	--"stone_with_copper",
	--"stone_with_diamond",
	--"stone_with_gold",
	--"stone_with_iron",
	--"stone_with_mese",
	--"stone_with_tin",
	"stone",
	"stonebrick",
	"tinblock",
	"tree",
	"wood",
}

for _, name in pairs(default_nodes) do
	local mod = "default"
	local nodename = mod .. ":" .. name
	local ndef = table.copy(minetest.registered_nodes[nodename])
	ndef.sunlight_propagates = true

	-- Stone and desert_stone drop cobble and desert_cobble respectively.
	if type(ndef.drop) == "string" then
		ndef.drop = ndef.drop:gsub(".+:", "")
	end

	-- Use the primary tile for all sides of cut glasslike nodes and disregard paramtype2.
	if #ndef.tiles > 1 and ndef.drawtype and ndef.drawtype:find("glass") then
		ndef.tiles = {ndef.tiles[1]}
		ndef.paramtype2 = nil
	end

	mod = "moreblocks"
	stairsplus:register_all(mod, name, nodename, ndef)
	minetest.register_alias_force("stairs:stair_" .. name, mod .. ":stair_" .. name)
	minetest.register_alias_force("stairs:stair_outer_" .. name, mod .. ":stair_" .. name .. "_outer")
	minetest.register_alias_force("stairs:stair_inner_" .. name, mod .. ":stair_" .. name .. "_inner")
	minetest.register_alias_force("stairs:slab_"  .. name, mod .. ":slab_"  .. name)
end

-- farming registrations
if minetest.get_modpath("farming") then
	local farming_nodes = {"straw"}
	for _, name in pairs(farming_nodes) do
		local mod = "farming"
		local nodename = mod .. ":" .. name
		local ndef = table.copy(minetest.registered_nodes[nodename])
		ndef.sunlight_propagates = true

		mod = "moreblocks"
		stairsplus:register_all(mod, name, nodename, ndef)
		minetest.register_alias_force("stairs:stair_" .. name, mod .. ":stair_" .. name)
		minetest.register_alias_force("stairs:stair_outer_" .. name, mod .. ":stair_" .. name .. "_outer")
		minetest.register_alias_force("stairs:stair_inner_" .. name, mod .. ":stair_" .. name .. "_inner")
		minetest.register_alias_force("stairs:slab_"  .. name, mod .. ":slab_"  .. name)
	end
end

-- wool registrations
if minetest.get_modpath("wool") then
	local dyes = {"white", "grey", "black", "red", "yellow", "green", "cyan",
	              "blue", "magenta", "orange", "violet", "brown", "pink",
	              "dark_grey", "dark_green"}
	for _, name in pairs(dyes) do
		local mod = "wool"
		local nodename = mod .. ":" .. name
		local ndef = table.copy(minetest.registered_nodes[nodename])
		ndef.sunlight_propagates = true

		stairsplus:register_all(mod, name, nodename, ndef)
	end
end

-- basic_materials, keeping the original other-mod-oriented names
-- for backwards compatibility

if minetest.get_modpath("basic_materials") then
	stairsplus:register_all("technic","concrete","basic_materials:concrete_block",{
		description = "Concrete",
		tiles = {"basic_materials_concrete_block.png",},
		groups = {cracky=1, level=2, concrete=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_alias("prefab:concrete_stair","technic:stair_concrete")
	minetest.register_alias("prefab:concrete_slab","technic:slab_concrete")

	stairsplus:register_all("gloopblocks", "cement", "basic_materials:cement_block", {
		description = "Cement",
		tiles = {"basic_materials_cement_block.png"},
		groups = {cracky=2, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
	})

	stairsplus:register_all("technic", "brass_block", "basic_materials:brass_block", {
		description="Brass Block",
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"basic_materials_brass_block.png"},
	})

end

-- Alias cuts of split_stone_tile_alt which was renamed checker_stone_tile.
stairsplus:register_alias_all("moreblocks", "split_stone_tile_alt", "moreblocks", "checker_stone_tile")

-- The following LBM is necessary because the name stair_split_stone_tile_alt
-- conflicts with another node and so the alias for that specific node gets
-- ignored.
minetest.register_lbm({
	name = "moreblocks:fix_split_stone_tile_alt_name_collision",
	nodenames = {"moreblocks:stair_split_stone_tile_alt"},
	action = function(pos, node)
		minetest.set_node(pos, {
			name = "moreblocks:stair_checker_stone_tile",
			param2 = minetest.get_node(pos).param2

		})
		minetest.log('action', "LBM replaced " .. node.name ..
			" at " .. minetest.pos_to_string(pos))
	end,
})
