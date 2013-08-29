-- Crafting

minetest.register_craft({
	output = "default:stick 1",
	recipe = {
		{"default:dry_shrub"},
	}
})

minetest.register_craft({
	output = "default:dirt_with_grass 1",
	recipe = {
		{"default:junglegrass"},
		{"default:dirt"},
	}
})

minetest.register_craft({
	output = "default:dirt_with_grass 1",
	recipe = {
		{"default:mese"},
		{"default:dirt"},
	}
})

minetest.register_craft({
	output = "default:mossycobble 1",
	recipe = {
		{"default:junglegrass"},
		{"default:cobble"},
	}
})

minetest.register_craft({
	output = "default:mossycobble 1",
	recipe = {
		{"default:mese"},
		{"default:cobble"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile 9",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile_flipped 1",
	recipe = {
		{"moreblocks:woodtile"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile_center 9",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "moreblocks:woodtile", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile_full 4",
	recipe = {
		{"moreblocks:woodtile", "moreblocks:woodtile"},
		{"moreblocks:woodtile", "moreblocks:woodtile"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile_up 1",
	recipe = {
		{"default:stick"},
		{"moreblocks:woodtile_center"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile_down 1",
	recipe = {
		{"moreblocks:woodtile_center"},
		{"default:stick"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile_left 1",
	recipe = {
		{"default:stick", "moreblocks:woodtile_center"},
	}
})

minetest.register_craft({
	output = "moreblocks:woodtile_right 1",
	recipe = {
		{"moreblocks:woodtile_center", "default:stick"},
	}
})

minetest.register_craft({
	output = "moreblocks:junglestick 4",
	recipe = {
		{"default:junglewood"},
	}
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
	output = "moreblocks:sweeper 3",
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
	output = "moreblocks:split_stone_tile 1",
	recipe = {
		{"moreblocks:stone_tile"},
	}
})

minetest.register_craft({
	output = "moreblocks:empty_bookshelf 1",
	recipe = {
		{"moreblocks:sweeper"},
		{"default:bookshelf"},
	}
})

minetest.register_craft({
	output = "moreblocks:iron_stone_bricks 1",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:stonebrick"},
})

minetest.register_craft({
	output = "default:wood 4",
	recipe = {
		{"moreblocks:horizontal_tree"},
	}
})

minetest.register_craft({
	output = "default:junglewood 4",
	recipe = {
		{"moreblocks:horizontal_jungle_tree"},
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
	output = "default:chest_locked 1",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:chest"},
})

minetest.register_craft({
	output = "moreblocks:iron_glass 1",
	type = "shapeless",
	recipe = {"default:steel_ingot", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:coal_glass 1",
	type = "shapeless",
	recipe = {"default:coal_lump", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:clean_glass 1",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:glow_glass 1",
	type = "shapeless",
	recipe = {"default:torch", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_glow_glass 1",
	type = "shapeless",
	walkable = false,
	recipe = {"default:mese_crystal", "default:glass", "default:torch"},
})

minetest.register_craft({
	output = "moreblocks:super_glow_glass 1",
	type = "shapeless",
	recipe = {"default:torch", "default:torch", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_super_glow_glass 1",
	type = "shapeless",
	walkable = false,
	recipe = {"default:mese_crystal", "default:glass", "default:torch", "default:torch"},
})

minetest.register_craft({
	output = "moreblocks:coal_stone 1",
	type = "shapeless",
	recipe = {"default:coal_lump", "default:stone"},
})

minetest.register_craft({
	output = "moreblocks:iron_stone 1",
	type = "shapeless",
	recipe = {"default:iron_lump", "default:stone"},
})

minetest.register_craft({
	output = "moreblocks:trap_stone 12",
	type = "shapeless",
	recipe = {"default:mese", "default:stone"},
})

minetest.register_craft({
	output = "moreblocks:trap_glass 12",
	type = "shapeless",
	recipe = {"default:mese", "default:glass"},
})

minetest.register_craft({
	output = "moreblocks:cactus_brick 1",
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
	output = "moreblocks:rope 2",
	recipe = {
		{"default:junglegrass"},
		{"default:junglegrass"},
		{"default:junglegrass"},
	}
})

minetest.register_craft({
	output = "moreblocks:horizontal_tree 2",
	recipe = {
		{"default:tree", "", "default:tree"},
	}
})

minetest.register_craft({
	output = "default:tree 2",
	recipe = {
		{"moreblocks:horizontal_tree"},
		{"moreblocks:horizontal_tree"},
	}
})

minetest.register_craft({
	output = "moreblocks:horizontal_jungle_tree 2",
	recipe = {
		{"default:jungletree", "", "default:jungletree"},
	}
})

minetest.register_craft({
	output = "default:jungletree 2",
	recipe = {
		{"moreblocks:horizontal_jungle_tree"},
		{"moreblocks:horizontal_jungle_tree"},
	}
})


minetest.register_craft({
		output = "moreblocks:circular_saw 1", 
		recipe = {
				{ "",  "default:steel_ingot",  "" },
				{ "default:tree",  "default:tree",  "default:tree"},
				{ "default:tree",  "",  "default:tree"},
		}
})
