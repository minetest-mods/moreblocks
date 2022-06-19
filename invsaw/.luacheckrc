std = "lua51+luajit+minetest+invsaw"
unused_args = false
max_line_length = 120

stds.minetest = {
	read_globals = {
		"DIR_DELIM",
		"minetest",
		"core",
		"dump",
		"vector",
		"nodeupdate",
		"VoxelManip",
		"VoxelArea",
		"PseudoRandom",
		"ItemStack",
		"default",
		"table",
	}
}

stds.moreblocks = {
	globals = {
		"invsaw",
	},
	read_globals = {
		"stairsplus",
		"unified_inventory",
	},
}
