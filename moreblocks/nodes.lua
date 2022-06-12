--[[
More Blocks: node definitions

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.S

local cm = moreblocks.resources.craft_materials
local t = moreblocks.resources.textures

local modname = moreblocks.modname

local sound_dirt = moreblocks.resources.sounds.dirt
local sound_wood = moreblocks.resources.sounds.wood
local sound_stone = moreblocks.resources.sounds.stone
local sound_glass = moreblocks.resources.sounds.glass
local sound_leaves = moreblocks.resources.sounds.leaves
local sound_metal = moreblocks.resources.sounds.metal

local function is_glasslike(def)
	return #def.tiles > 1 and (
		def.drawtype == "glasslike_framed" or
		def.drawtype == "glasslike_framed_optional"
	)
end

local function register_stairs(name, def)
	local itemstring = ("%s:%s"):format(modname, name)

	-- Use the primary tile for all sides of cut glasslike nodes.
	-- This makes them easier to see
	if is_glasslike(def) then
		def = table.copy(def)
		def.tiles = {def.tiles[1]}
	end

	if moreblocks.has.stairsplus then
		stairsplus:register_all(modname, name, itemstring, {
			description = def.description,
			groups = def.groups,
			tiles = def.tiles,
			sunlight_propagates = def.sunlight_propagates,
			light_source = def.light_source,
			sounds = def.sounds,
		})
	elseif moreblocks.has.stairs then
		stairs.register_stair_and_slab(
			("%s_%s"):format(modname, name),
			itemstring,
			def.groups,
			def.tiles,
			S("@1 Stair", def.description),
			S("@1 Slab", def.description),
			def.sounds,
			true
		)
	end
end


local function tile_tiles(tex)
	return {tex, tex, tex, tex, tex .. "^[transformR90", tex .. "^[transformR90"}
end

local function register_with_stairs(name, def)
	local itemstring = ("%s:%s"):format(modname, name)
	def.tiles = def.tiles or {("%s_%s.png"):format(modname, name)}
	minetest.register_node(itemstring, def)
	minetest.register_alias(name, itemstring)
	register_stairs(name, def)
end

local function register_no_stairs(name, def)
	local itemstring = ("%s:%s"):format(modname, name)
	def.tiles = def.tiles or {("%s_%s.png"):format(modname, name)}
	minetest.register_node(itemstring, def)
	minetest.register_alias(name, itemstring)
end

local function register_all_faces(name, base)
	name = "all_faces_" .. name
	local itemstring = ("%s:%s"):format(modname, name)
	moreblocks.api.register_all_faces(itemstring, base)
	register_stairs(name, minetest.registered_nodes[itemstring])
	minetest.register_alias(name, itemstring)
end


local function register_trap(name, base)
	name = "trap_" .. name
	local itemstring = ("%s:%s"):format(modname, name)
	moreblocks.api.register_trap(itemstring, base)
	minetest.register_alias(name, itemstring)
end

register_with_stairs("wood_tile", {
	description = S("Wooden Tile"),
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	is_ground_content = false,
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = tile_tiles(("%s^moreblocks_wood_tile.png"):format(t.wood)),
	sounds = sound_wood,
})

register_with_stairs("wood_tile_center", {
	description = S("Centered Wooden Tile"),
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	is_ground_content = false,
	tiles = {
		("%s^moreblocks_wood_tile_center.png"):format(t.wood)
	},
	sounds = sound_wood,
})

register_with_stairs("wood_tile_full", {
	description = S("Full Wooden Tile"),
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	is_ground_content = false,
	tiles = tile_tiles("moreblocks_wood_tile_full.png"),
	sounds = sound_wood,
})

register_no_stairs("wood_tile_offset", {
	description = S("Offset Wooden Tile"),
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	is_ground_content = false,
	tiles = {
		("%s^moreblocks_wood_tile_offset.png"):format(t.wood)
	},
	sounds = sound_wood,
})

register_with_stairs("circle_stone_bricks", {
	description = S("Circle Stone Bricks"),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("grey_bricks", {
	description = S("Stone Bricks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("coal_stone_bricks", {
	description = S("Coal Stone Bricks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("iron_stone_bricks", {
	description = S("Iron Stone Bricks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("stone_tile", {
	description = S("Stone Tile"),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("split_stone_tile", {
	description = S("Split Stone Tile"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {
		"moreblocks_split_stone_tile_top.png",
		"moreblocks_split_stone_tile.png"
	},
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("checker_stone_tile", {
	description = S("Checker Stone Tile"),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("tar", {
	description = S("Tar"),
	groups = {cracky = 2, tar_block = 1},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("dirt_compressed", {
	description = S("Compressed Dirt"),
	groups = {crumbly = 2},
	is_ground_content = false,
	sounds = sound_dirt,
})

register_with_stairs("cobble_compressed", {
	description = S("Compressed Cobblestone"),
	groups = {cracky = 1},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("desert_cobble_compressed", {
	description = S("Compressed Desert Cobblestone"),
	groups = {cracky = 1},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("plankstone", {
	description = S("Plankstone"),
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {cracky = 3},
	is_ground_content = false,
	tiles = tile_tiles("moreblocks_plankstone.png"),
	sounds = sound_stone,
})

register_with_stairs("iron_glass", {
	description = S("Iron Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {
		("%s^[colorize:#DEDEDE"):format(t.glass),
		("%s^[colorize:#DEDEDE"):format(t.glass_detail)
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sound_glass,
})

register_with_stairs("coal_glass", {
	description = S("Coal Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {
		("%s^[colorize:#828282"):format(t.glass),
		("%s^[colorize:#828282"):format(t.glass_detail)
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sound_glass,
})

register_with_stairs("clean_glass", {
	description = S("Clean Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {
		"moreblocks_clean_glass.png",
		"moreblocks_clean_glass_detail.png"
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sound_glass,
})

register_with_stairs("cactus_brick", {
	description = S("Cactus Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	groups = {cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("cactus_checker", {
	description = S("Cactus Checker"),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	tiles = tile_tiles(("%s^moreblocks_cactus_checker.png"):format(t.stone)),
	sounds = sound_stone,
})

register_no_stairs("empty_shelf", {
	description = S("Empty Shelf"),
	paramtype2 = "facedir",
	tiles = {
		t.wood,
		t.wood,
		t.wood,
		t.wood,
		"moreblocks_empty_shelf.png",
		"moreblocks_empty_shelf.png"
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	is_ground_content = false,
	sounds = sound_wood,
	furnace_burntime = 15,
})

register_with_stairs("coal_stone", {
	description = S("Coal Stone"),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("iron_stone", {
	description = S("Iron Stone"),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("coal_checker", {
	description = S("Coal Checker"),
	tiles = tile_tiles(("%s^moreblocks_coal_checker.png"):format(t.stone)),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("iron_checker", {
	description = S("Iron Checker"),
	tiles = tile_tiles(("%s^moreblocks_iron_checker.png"):format(t.stone)),
	groups = {stone = 1, cracky = 3},
	is_ground_content = false,
	sounds = sound_stone,
})

register_with_stairs("glow_glass", {
	description = S("Glow Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {
		("%s^[colorize:#E9CD61"):format(t.glass),
		("%s^[colorize:#E9CD61"):format(t.glass_detail)
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	light_source = 11,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sound_glass,
})

register_with_stairs("super_glow_glass", {
	description = S("Super Glow Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {
		("%s^[colorize:#FFFF78"):format(t.glass),
		("%s^[colorize:#FFFF78"):format(t.glass_detail)
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	light_source = minetest.LIGHT_MAX,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sound_glass,
})

register_with_stairs("clean_glow_glass", {
	description = S("Clean Glow Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {
		"moreblocks_clean_glass.png^[colorize:#E9CD61",
		"moreblocks_clean_glass_detail.png^[colorize:#E9CD61"
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	light_source = 11,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sound_glass,
})

register_with_stairs("clean_super_glow_glass", {
	description = S("Clean Super Glow Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {
		"moreblocks_clean_glass.png^[colorize:#FFFF78",
		"moreblocks_clean_glass_detail.png^[colorize:#FFFF78"
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	light_source = minetest.LIGHT_MAX,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sound_glass,
})

register_with_stairs("copperpatina", {
	description = S("Copper Patina Block"),
	groups = {cracky = 1, level = 2},
	is_ground_content = false,
	sounds = sound_metal,
})

register_no_stairs("rope", {
	description = S("Rope"),
	drawtype = "signlike",
	inventory_image = "moreblocks_rope.png",
	wield_image = "moreblocks_rope.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	selection_box = {type = "wallmounted", },
	groups = {snappy = 3, flammable = 2},
	sounds = sound_leaves,
})

register_trap("clean_glass", "moreblocks:clean_glass")
register_trap("clean_glow_glass", "moreblocks:clean_glow_glass")
register_trap("clean_super_glow_glass", "moreblocks:clean_super_glow_glass")

if cm.stone then
	register_trap("stone", cm.stone)
end

if cm.desert_stone then
	register_trap("desert_stone", cm.desert_stone)
end

if cm.glass then
	register_trap("glass", cm.glass)
	register_trap("glow_glass", "moreblocks:glow_glass")
	register_trap("super_glow_glass", "moreblocks:super_glow_glass")
end

if cm.obsidian_glass then
	register_trap("obsidian_glass", cm.obsidian_glass)
end

if cm.obsidian then
	register_trap("obsidian", cm.obsidian)
end

if cm.obsidian then
	register_trap("obsidian", cm.obsidian)
end

if cm.sandstone then
	register_trap("sandstone", cm.sandstone)
end

if cm.tree then
	register_all_faces("tree", cm.tree)
end

if cm.jungle_tree then
	register_all_faces("jungle_tree", cm.jungle_tree)
end

if cm.pine_tree then
	register_all_faces("pine_tree", cm.pine_tree)
end

if cm.acacia_tree then
	register_all_faces("acacia_tree", cm.acacia_tree)
end

if cm.aspen_tree then
	register_all_faces("aspen_tree", cm.aspen_tree)
end
