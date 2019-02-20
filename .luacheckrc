std = "lua51+minetest"
unused_args = false
allow_defined_top = true
max_line_length = 999

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
		table = {
			fields = {
				"copy",
			},
		},
	}
}

read_globals = {
	"intllib",
	"protector",
	"isprotect",
	"IsPlayerNodeOwner",
	"HasOwner",
	"getLastOwner",
	"GetNodeOwnerName",
}
