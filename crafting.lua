--[[
More Blocks: crafting recipes

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

minetest.register_craft({
	output = "default:stick",
	recipe = {{"default:dry_shrub"},}
})

minetest.register_craft({
	output = "default:stick",
	recipe = {{"group:sapling"},}
})

minetest.register_craft({
	output = "default:wood",
	recipe = {
		{"default:stick", "default:stick"},
		{"default:stick", "default:stick"},
	}
})

minetest.register_craft({
	output = "default:dirt_with_grass",
	type = "shapeless",
	recipe = {"default:junglegrass", "default:dirt"},
})

minetest.register_craft({
	output = "default:mossycobble",
	type = "shapeless",
	recipe = {"default:junglegrass", "default:cobble"},
})

minetest.register_craft({
	output = "moreblocks:wood_tile 9",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

-- This must be registered after `moreblocks:wood_tile` to avoid recipe conflicts,
-- since `moreblocks:wood_tile` is part of `group:wood`
minetest.register_craft({
	output = "moreblocks:wood_tile_center 9",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "moreblocks:wood_tile", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile",
	recipe = {"moreblocks:wood_tile_flipped"}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_full 4",
	recipe = {
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
	}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_offset",
	recipe = {
		{"default:stick"},
		{"moreblocks:wood_tile_center"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_down"}
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_left"}
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_right"}
})

minetest.register_craft({
	output = "moreblocks:circle_stone_bricks 5",
	recipe = {
		{"", "default:stone", ""},
		{"default:stone", "default:coal_lump", "default:stone"},
		{"", "default:stone", ""},
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
	output = "moreblocks:all_faces_pine_tree 8",
	recipe = {
		{"default:pine_tree", "default:pine_tree", "default:pine_tree"},
		{"default:pine_tree", "", "default:pine_tree"},
		{"default:pine_tree", "default:pine_tree", "default:pine_tree"},
	}
})

minetest.register_craft({
	output = "moreblocks:all_faces_acacia_tree 8",
	recipe = {
		{"default:acacia_tree", "default:acacia_tree", "default:acacia_tree"},
		{"default:acacia_tree", "", "default:acacia_tree"},
		{"default:acacia_tree", "default:acacia_tree", "default:acacia_tree"},
	}
})

minetest.register_craft({
	output = "moreblocks:all_faces_aspen_tree 8",
	recipe = {
		{"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
		{"default:aspen_tree", "", "default:aspen_tree"},
		{"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
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
	output = "moreblocks:stone_tile 9",
	recipe = {
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "default:stone", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"},
	}
})

minetest.register_craft({
	output = "moreblocks:split_stone_tile",
	recipe = {
		{"moreblocks:stone_tile"},
	}
})

minetest.register_craft({
	output = "moreblocks:checker_stone_tile",
	recipe = {
		{"moreblocks:split_stone_tile"},
	}
})

-- When approaching the below craft, loop back to cobblestone, which can then be used to craft stone tiles again
minetest.register_craft({
	output = "default:cobble",
	recipe = {
		{"moreblocks:checker_stone_tile"},
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
	output = "moreblocks:empty_shelf",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "default:bookshelf"},
	replacements = {{"default:bookshelf", "default:book 3"}},
	-- When obtaining an empty shelf, return the books used in it as well
})

minetest.register_craft({
	output = "moreblocks:empty_shelf",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "vessels:shelf"},
	replacements = {{"vessels:shelf", "vessels:glass_bottle 3"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:bookshelf",
	recipe = {"moreblocks:empty_shelf", "default:book", "default:book", "default:book"},
})

minetest.register_craft({
	output = "moreblocks:empty_shelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"", "", ""},
		{"group:wood", "group:wood", "group:wood"},
	}
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
		{"group:stone", "group:wood"},
		{"group:wood", "group:stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"group:wood", "group:stone"},
		{"group:stone", "group:wood"},
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
	output = "moreblocks:trap_clean_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:clean_glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:trap_glass"},
})

minetest.register_craft({
	output = "moreblocks:glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:clean_glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "moreblocks:clean_glass"},
})

minetest.register_craft({
	output = "moreblocks:clean_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:glow_glass"},
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

-- several recipes are possible for the trap+clean+glow, we only present 3 of them
minetest.register_craft({
	output = "moreblocks:trap_clean_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:clean_glow_glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:clean_glass", "default:torch"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:trap_glow_glass" },
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
	output = "moreblocks:clean_super_glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "default:torch", "moreblocks:clean_glass"},
})

minetest.register_craft({
	output = "moreblocks:clean_super_glow_glass",
	type = "shapeless",
	recipe = {"default:torch", "moreblocks:clean_glow_glass"},
})

minetest.register_craft({
	output = "moreblocks:clean_super_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:super_glow_glass"},
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

-- several recipes are possible for the trap+clean+glow, we only present 4 of them
minetest.register_craft({
	output = "moreblocks:trap_clean_super_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:clean_super_glow_glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_super_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:clean_glow_glass", "default:torch"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_super_glow_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "moreblocks:clean_glass", "default:torch", "default:torch"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_super_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:trap_super_glow_glass" },
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
	output = "moreblocks:trap_desert_stone",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:desert_stone"},
})

minetest.register_craft({
	output = "moreblocks:trap_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_obsidian_glass",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:obsidian_glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_obsidian",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:obsidian"},
})

minetest.register_craft({
	output = "moreblocks:trap_sandstone",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:sandstone"},
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
	output = "moreblocks:dirt_compressed",
	recipe = {
		{'default:dirt', 'default:dirt', 'default:dirt'},
		{'default:dirt', 'default:dirt', 'default:dirt'},
		{'default:dirt', 'default:dirt', 'default:dirt'},
	}
})

minetest.register_craft({
	output = "default:dirt 9",
	recipe = {{"moreblocks:dirt_compressed"}},
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
	output = "moreblocks:desert_cobble_compressed",
	recipe = {
		{"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"},
		{"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"},
		{"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"},
	}
})

minetest.register_craft({
	output = "default:desert_cobble 9",
	recipe = {
		{"moreblocks:desert_cobble_compressed"},
	}
})

minetest.register_craft({
	type = "cooking", output = "moreblocks:tar", recipe = "default:pine_tree",
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:copperpatina",
	recipe = {"group:water_bucket", "default:copperblock"},
	replacements = {
		{"group:water_bucket", "bucket:bucket_empty"}
	}
})

minetest.register_craft({
	output = "default:copper_ingot 9",
	recipe = {
		{"moreblocks:copperpatina"},
	}
})

if minetest.settings:get_bool("moreblocks.circular_saw_crafting") ~= false then -- “If nil or true then”
	minetest.register_craft({
		output = "moreblocks:circular_saw",
		recipe = {
			{ "",  "default:steel_ingot",  "" },
			{ "group:wood",  "group:wood",  "group:wood"},
			{ "group:wood",  "",  "group:wood"},
		}
	})
end
