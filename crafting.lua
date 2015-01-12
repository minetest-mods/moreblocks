--[[
More Blocks: crafting recipes

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

minetest.register_craft({
	output = "default:stick",
	recipe = {{"default:dry_shrub"},}
})

minetest.register_craft({
	output = "default:stick",
	recipe = {{"default:sapling"},}
})

minetest.register_craft({
	output = "default:stick",
	recipe = {{"default:junglesapling"},}
})

minetest.register_craft({
	output = "default:wood",
	recipe = {
		{"default:stick", "default:stick"},
		{"default:stick", "default:stick"},
	}
})

minetest.register_craft({
	output = "default:junglewood",
	recipe = {
		{"moreblocks:jungle_stick", "moreblocks:jungle_stick"},
		{"moreblocks:jungle_stick", "moreblocks:jungle_stick"},
	}
})

minetest.register_craft({
	output = "default:dirt_with_grass",
	type = "shapeless",
	recipe = {"default:junglegrass", "default:dirt"},
})

minetest.register_craft({
	output = "default:dirt_with_grass",
	type = "shapeless",
	recipe = {"default:mese", "default:dirt"},
})

minetest.register_craft({
	output = "default:mossycobble",
	type = "shapeless",
	recipe = {"default:junglegrass", "default:cobble"},
})

minetest.register_craft({
	output = "default:mossycobble",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:cobble"},
})

minetest.register_craft({
	output = "moreblocks:wood_tile 9",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_flipped",
	recipe = {{"moreblocks:wood_tile"},}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_center 9",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "moreblocks:wood_tile", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_full 4",
	recipe = {
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
	}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_up",
	recipe = {
		{"default:stick"},
		{"moreblocks:wood_tile_center"},
	}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_down",
	recipe = {
		{"moreblocks:wood_tile_center"},
		{"default:stick"},
	}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_left",
	recipe = {
		{"default:stick", "moreblocks:wood_tile_center"},
	}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_right",
	recipe = {
		{"moreblocks:wood_tile_center", "default:stick"},
	}
})

minetest.register_craft({
	output = "moreblocks:junglestick 4",
	recipe = {{"default:junglewood"},}
})

minetest.register_craft({
	output = "moreblocks:fence_jungle_wood 2",
	recipe = {
		{"moreblocks:jungle_stick", "moreblocks:jungle_stick", "moreblocks:jungle_stick"},
		{"moreblocks:jungle_stick", "moreblocks:jungle_stick", "moreblocks:jungle_stick"},
	}
})

minetest.register_craft({
	output = "moreblocks:circle_stone_bricks 8",
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:stone", "", "default:stone"},
		{"default:stone", "default:stone", "default:stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:all_faces_tree 8",
	recipe = {
		{"default:tree", "default:tree", "default:tree"},
		{"default:tree", "", "default:tree"},
		{"default:tree", "default:tree", "default:tree"},
	}
})

minetest.register_craft({
	output = "moreblocks:all_faces_jungle_tree 8",
	recipe = {
		{"default:jungletree", "default:jungletree", "default:jungletree"},
		{"default:jungletree", "", "default:jungletree"},
		{"default:jungletree", "default:jungletree", "default:jungletree"},
	}
})

minetest.register_craft({
	output = "moreblocks:sweeper 4",
	recipe = {
		{"default:junglegrass"},
		{"default:stick"},
	}
})

minetest.register_craft({
	output = "moreblocks:stone_tile 4",
	recipe = {
		{"default:cobble", "default:cobble"},
		{"default:cobble", "default:cobble"},
	}
})

minetest.register_craft({
	output = "moreblocks:split_stone_tile",
	recipe = {
		{"moreblocks:stone_tile"},
	}
})

minetest.register_craft({
	output = "moreblocks:split_stone_tile_alt",
	recipe = {
		{"moreblocks:split_stone_tile"},
	}
})

minetest.register_craft({
	output = "moreblocks:grey_bricks 2",
	type = "shapeless",
	recipe =  {"default:stone", "default:brick"},
})

minetest.register_craft({
	output = "moreblocks:grey_bricks 2",
	type = "shapeless",
	recipe =  {"default:stonebrick", "default:brick"},
})

minetest.register_craft({
	output = "moreblocks:empty_bookshelf",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "default:bookshelf"},
})

minetest.register_craft({
	output = "moreblocks:coal_stone_bricks 4",
	recipe = {
		{"moreblocks:coal_stone", "moreblocks:coal_stone"},
		{"moreblocks:coal_stone", "moreblocks:coal_stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:iron_stone_bricks 4",
	recipe = {
		{"moreblocks:iron_stone", "moreblocks:iron_stone"},
		{"moreblocks:iron_stone", "moreblocks:iron_stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"default:stone", "default:wood"},
		{"default:wood", "default:stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"default:wood", "default:stone"},
		{"default:stone", "default:wood"},
	}
})

minetest.register_craft({
	output = "moreblocks:coal_checker 4",
	recipe = {
		{"default:stone", "default:coal_lump"},
		{"default:coal_lump", "default:stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:coal_checker 4",
	recipe = {
		{"default:coal_lump", "default:stone"},
		{"default:stone", "default:coal_lump"},
	}
})

minetest.register_craft({
	output = "moreblocks:iron_checker 4",
	recipe = {
		{"default:steel_ingot", "default:stone"},
		{"default:stone", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "moreblocks:iron_checker 4",
	recipe = {
		{"default:stone", "default:steel_ingot"},
		{"default:steel_ingot", "default:stone"},
	}
})

minetest.register_craft({
	output = "default:chest_locked",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:chest"},
})
minetest.register_craft({
	output = "default:chest_locked",
	type = "shapeless",
	recipe = {"default:copper_ingot", "default:chest"},
})

minetest.register_craft({
	output = "default:chest_locked",
	type = "shapeless",
	recipe = {"default:bronze_ingot", "default:chest"},
})

minetest.register_craft({
	output = "default:chest_locked",
	type = "shapeless",
	recipe = {"default:gold_ingot", "default:chest"},
})

minetest.register_craft({
	output = "moreblocks:iron_glass",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:glass"},
})

minetest.register_craft({
	output = "default:glass",
	type = "shapeless",
	recipe = {"default:coal_lump", "moreblocks:iron_glass"},
})


minetest.register_craft({
	output = "moreblocks:coal_glass",
	type = "shapeless",
	recipe = {"default:coal_lump", "default:glass"},
})

minetest.register_craft({
	output = "default:glass",
	type = "shapeless",
	recipe = {"default:steel_ingot", "moreblocks:coal_glass"},
})

minetest.register_craft({
	output = "moreblocks:clean_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:glass", "default:torch"},
})

minetest.register_craft({
	output = "moreblocks:trap_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:glow_glass"},
})

minetest.register_craft({
	output = "moreblocks:super_glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "default:torch", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:super_glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "moreblocks:glow_glass"},
})


minetest.register_craft({
	output = "moreblocks:trap_super_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:glass", "default:torch", "default:torch"},
})

minetest.register_craft({
	output = "moreblocks:trap_super_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:super_glow_glass"},
})

minetest.register_craft({
	output = "moreblocks:coal_stone",
	type = "shapeless",
	recipe = {"default:coal_lump", "default:stone"},
})

minetest.register_craft({
	output = "default:stone",
	type = "shapeless",
	recipe = {"default:steel_ingot", "moreblocks:coal_stone"},
})

minetest.register_craft({
	output = "moreblocks:iron_stone",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:stone"},
})

minetest.register_craft({
	output = "default:stone",
	type = "shapeless",
	recipe = {"default:coal_lump", "moreblocks:iron_stone"},
})

minetest.register_craft({
	output = "moreblocks:trap_stone",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:stone"},
})

minetest.register_craft({
	output = "moreblocks:trap_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:cactus_brick",
	type = "shapeless",
	recipe = {"default:cactus", "default:brick"},
})

minetest.register_craft({
	output = "moreblocks:cactus_checker 4",
	recipe = {
		{"default:cactus", "default:stone"},
		{"default:stone", "default:cactus"},
	}
})

minetest.register_craft({
	output = "moreblocks:cactuschecker 4",
	recipe = {
		{"default:stone", "default:cactus"},
		{"default:cactus", "default:stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:rope 3",
	recipe = {
		{"default:junglegrass"},
		{"default:junglegrass"},
		{"default:junglegrass"},
	}
})

minetest.register_craft({
	output = "moreblocks:cobble_compressed",
	recipe = {
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"},
	}
})

minetest.register_craft({
	output = "default:cobble 9",
	recipe = {
		{"moreblocks:cobble_compressed"},
	}
})

minetest.register_craft({
	type = "cooking", output = "moreblocks:tar", recipe = "default:gravel",
})

minetest.register_craft({
	output = "moreblocks:circular_saw", 
	recipe = {
		{ "",  "default:steel_ingot",  "" },
		{ "group:wood",  "group:wood",  "group:wood"},
		{ "group:wood",  "",  "group:wood"},
	}
})
