--[[
****
More Blocks
by Calinou
Licensed under the zlib/libpng license for code and CC BY-SA for textures, see LICENSE.txt for info.
****
--]]

moreblocks = {}

-- Load translation library if intllib is installed

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
	else
	S = function ( s ) return s end
end
moreblocks.gettext = S

dofile(minetest.get_modpath("moreblocks").."/_config.txt")

dofile(minetest.get_modpath("moreblocks").."/ownership.lua")
dofile(minetest.get_modpath("moreblocks").."/redefinitions.lua")
dofile(minetest.get_modpath("moreblocks").."/crafting.lua")
dofile(minetest.get_modpath("moreblocks").."/aliases.lua")
dofile(minetest.get_modpath("moreblocks").."/stairsplus_convert.lua")
dofile(minetest.get_modpath("moreblocks").."/stairsplus/stairs.lua")
dofile(minetest.get_modpath("moreblocks").."/stairsplus/slabs.lua")
dofile(minetest.get_modpath("moreblocks").."/stairsplus/panels.lua")
dofile(minetest.get_modpath("moreblocks").."/stairsplus/microblocks.lua")
dofile(minetest.get_modpath("moreblocks").."/stairsplus/aliases.lua")
dofile(minetest.get_modpath("moreblocks").."/stairsplus.lua")
dofile(minetest.get_modpath("moreblocks").."/circular_saw.lua")

-- Blocks

minetest.register_node("moreblocks:wood_tile", {
	description = S("Wooden Tile"),
	tiles = {"moreblocks_wood_tile.png", "moreblocks_wood_tile.png", "moreblocks_wood_tile.png", "moreblocks_wood_tile.png", "moreblocks_wood_tile.png^[transformR90", "moreblocks_wood_tile.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:wood_tile_flipped", {
	description = S("Wooden Tile"),
	tiles = {"moreblocks_wood_tile_flipped.png", "moreblocks_wood_tile_flipped.png", "moreblocks_wood_tile_flipped.png", "moreblocks_wood_tile_flipped.png", "moreblocks_wood_tile_flipped.png^[transformR90", "moreblocks_wood_tile_flipped.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:wood_tile_center", {
	description = S("Centered Wooden Tile"),
	tiles = {"moreblocks_wood_tile_center.png", "moreblocks_wood_tile_center.png", "moreblocks_wood_tile_center.png", "moreblocks_wood_tile_center.png", "moreblocks_wood_tile_center.png^[transformR90", "moreblocks_wood_tile_center.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:wood_tile_full", {
	description = S("Full Wooden Tile"),
	tiles = {"moreblocks_wood_tile_full.png", "moreblocks_wood_tile_full.png", "moreblocks_wood_tile_full.png",
	"moreblocks_wood_tile_full.png", "moreblocks_wood_tile_full.png^[transformR90", "moreblocks_wood_tile_full.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:wood_tile_up", {
	description = S("Up Wooden Tile"),
	tiles = {"moreblocks_wood_tile_up.png", "moreblocks_wood_tile_up.png", "moreblocks_wood_tile_up.png",
	"moreblocks_wood_tile_up.png", "moreblocks_wood_tile_up.png^[transformR90", "moreblocks_wood_tile_up.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:wood_tile_down", {
	description = S("Down Wooden Tile"),
	tiles = {"moreblocks_wood_tile_down.png", "moreblocks_wood_tile_down.png", "moreblocks_wood_tile_down.png",
	"moreblocks_wood_tile_down.png", "moreblocks_wood_tile_down.png^[transformR90", "moreblocks_wood_tile_down.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:wood_tile_left", {
	description = S("Left Wooden Tile"),
	tiles = {"moreblocks_wood_tile_left.png", "moreblocks_wood_tile_left.png", "moreblocks_wood_tile_left.png",
	"moreblocks_wood_tile_left.png", "moreblocks_wood_tile_left.png^[transformR90", "moreblocks_wood_tile_left.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:wood_tile_right", {
	description = S("Right Wooden Tile"),
	tiles = {"moreblocks_wood_tile_right.png", "moreblocks_wood_tile_right.png", "moreblocks_wood_tile_right.png",
	"moreblocks_wood_tile_right.png", "moreblocks_wood_tile_right.png^[transformR90", "moreblocks_wood_tile_right.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:circle_stone_bricks", {
	description = S("Circle Stone Bricks"),
	tiles = {"moreblocks_circle_stone_bricks.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:coal_stone_bricks", {
	description = S("Coal Stone Bricks"),
	tiles = {"moreblocks_coal_stone_bricks.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:iron_stone_bricks", {
	description = S("Iron Stone Bricks"),
	tiles = {"moreblocks_iron_stone_bricks.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:stone_tile", {
	description = S("Stone Tile"),
	tiles = {"moreblocks_stone_tile.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:split_stone_tile", {
	description = S("Split Stone Tile"),
	tiles = {"moreblocks_split_stone_tile_top.png", "moreblocks_split_stone_tile.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:plankstone", {
	description = S("Plankstone"),
	tiles = {"moreblocks_plankstone.png", "moreblocks_plankstone.png", "moreblocks_plankstone.png",
	"moreblocks_plankstone.png", "moreblocks_plankstone.png^[transformR90", "moreblocks_plankstone.png^[transformR90"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:iron_glass", {
	description = S("Iron Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_iron_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_iron_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:coal_glass", {
	description = S("Coal Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_coal_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_coal_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:clean_glass", {
	description = S("Clean Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_clean_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_clean_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("moreblocks:cactus_brick", {
	description = S("Cactus Brick"),
	tiles = {"moreblocks_cactus_brick.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:cactus_checker", {
	description = S("Cactus Checker"),
	tiles = {"moreblocks_cactus_checker.png", "moreblocks_cactus_checker.png", "moreblocks_cactus_checker.png",
	"moreblocks_cactus_checker.png", "moreblocks_cactus_checker.png^[transformR90", "moreblocks_cactus_checker.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:empty_bookshelf", {
	description = S("Empty Bookshelf"),
	tiles = {"default_wood.png", "default_wood.png", "moreblocks_empty_bookshelf.png"},
	groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:coal_stone", {
	description = S("Coal Stone"),
	tiles = {"moreblocks_coal_stone.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:iron_stone", {
	description = S("Iron Stone"),
	tiles = {"moreblocks_iron_stone.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:coal_checker", {
	description = S("Coal Checker"),
	tiles = {"moreblocks_coal_checker.png", "moreblocks_coal_checker.png", "moreblocks_coal_checker.png",
	"moreblocks_coal_checker.png", "moreblocks_coal_checker.png^[transformR90", "moreblocks_coal_checker.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:iron_checker", {
	description = S("Iron Checker"),
	tiles = {"moreblocks_iron_checker.png", "moreblocks_iron_checker.png", "moreblocks_iron_checker.png",
	"moreblocks_iron_checker.png", "moreblocks_iron_checker.png^[transformR90", "moreblocks_iron_checker.png^[transformR90"},
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:trap_stone", {
	description = S("Trap Stone"),
	tiles = {"moreblocks_trap_stone.png"},
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:trap_glass", {
	description = S("Trap Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_trap_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_trap_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:fence_jungle_wood", {
	description = S("Jungle Wood Fence"),
	drawtype = "fencelike",
	tiles = {"moreblocks_jungle_wood.png"},
	inventory_image = "moreblocks_fence_jungle_wood.png",
	wield_image = "moreblocks_fence_jungle_wood.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:horizontal_tree", {
	description = S("Horizontal Tree"),
	tiles = {"default_tree.png", "default_tree.png", "default_tree.png^[transformR90",
	"default_tree.png^[transformR90", "default_tree_top.png", "default_tree_top.png"},
	paramtype2 = "facedir",
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:horizontal_jungle_tree", {
	description = S("Horizontal Jungle Tree"),
	tiles = {"default_jungletree.png", "default_jungletree.png", "default_jungletree.png^[transformR90",
	"default_jungletree.png^[transformR90", "default_jungletree_top.png", "default_jungletree_top.png"},
	paramtype2 = "facedir",
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:all_faces_tree", {
	description = S("All-faces Tree"),
	tiles = {"default_tree_top.png"},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:all_faces_jungle_tree", {
	description = S("All-faces Tree"),
	tiles = {"default_jungletree_top.png"},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:glow_glass", {
	description = S("Glow Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_glow_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_glow_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 11,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("moreblocks:trap_glow_glass", {
	description = S("Trap Glow Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_glow_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_glow_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 11,
	walkable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:super_glow_glass", {
	description = S("Super Glow Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_super_glow_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_super_glow_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 15,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:trap_super_glow_glass", {
	description = S("Trap Super Glow Glass"),
	drawtype = "glasslike",
	tiles = {"moreblocks_glow_glass.png"},
	inventory_image = minetest.inventorycube("moreblocks_glow_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 11,
	walkable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:rope", {
	description = S("Rope"),
	drawtype = "signlike",
	tiles = {"moreblocks_rope.png"},
	inventory_image = "moreblocks_rope.png",
	wield_image = "moreblocks_rope.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-- Items

minetest.register_craftitem("moreblocks:sweeper", {
	description = S("Sweeper"),
	inventory_image = "moreblocks_sweeper.png",
})

minetest.register_craftitem("moreblocks:jungle_stick", {
	description = S("Jungle Stick"),
	inventory_image = "moreblocks_junglestick.png",
	groups = {stick=1},
})

minetest.register_craftitem("moreblocks:nothing", {
	on_use = minetest.item_eat(0),
})

print(S("[moreblocks] loaded."))
