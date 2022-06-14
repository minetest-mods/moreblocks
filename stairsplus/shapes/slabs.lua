stairsplus.api.register_shape("slab_1", {
	name_format = "slab_%s_1",
	description = "@1 1/16 Slab",
	shape_groups = {slab = 1, common = 1},
	eighths = 1,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
})

stairsplus.api.register_shape("slab_2", {
	name_format = "slab_%s_2",
	description = "@1 1/8 Slab",
	shape_groups = {slab = 1},
	eighths = 1,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
	},
})

stairsplus.api.register_shape("slab_4", {
	name_format = "slab_%s_4",
	aliases = {"slab_%s_quarter"},
	description = "@1 1/4 Slab",
	shape_groups = {slab = 1},
	eighths = 2,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
	},
})

stairsplus.api.register_shape("slab_8", {
	name_format = "slab_%s_8",
	aliases = {"slab_%s"},
	description = "@1 1/2 Slab",
	shape_groups = {slab = 1, common = 1},
	eighths = 4,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
})

stairsplus.api.register_shape("slab_12", {
	name_format = "slab_%s_12",
	aliases = {"slab_%s_three_quarter"},
	description = "@1 3/4 Slab",
	shape_groups = {slab = 1},
	eighths = 6,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
	},
})

stairsplus.api.register_shape("slab_14", {
	name_format = "slab_%s_14",
	description = "@1 7/8 Slab",
	shape_groups = {slab = 1},
	eighths = 7,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},
	},
})

stairsplus.api.register_shape("slab_15", {
	name_format = "slab_%s_15",
	description = "@1 15/16 Slab",
	shape_groups = {slab = 1},
	eighths = 7,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
	},
})

--- these terrible things

stairsplus.api.register_shape("slab_two_sides", {
	name_format = "slab_%s_two_sides",
	description = "@1 1/16 Slab Two Sides",
	shape_groups = {slab = 1},
	eighths = 2,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -7 / 16, 7 / 16},
			{-0.5, -0.5, 7 / 16, 0.5, 0.5, 0.5}
		},
	},
})

stairsplus.api.register_shape("slab_three_sides", {
	name_format = "slab_%s_three_sides",
	description = "@1 1/16 Slab Three Sides",
	shape_groups = {slab = 1},
	eighths = 3,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-7 / 16, -0.5, -0.5, 0.5, -7 / 16, 7 / 16},
			{-7 / 16, -0.5, 7 / 16, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, -7 / 16, 0.5, 0.5}
		},
	},
})

stairsplus.api.register_shape("slab_three_sides_u", {
	name_format = "slab_%s_three_sides_u",
	description = "@1 1/16 Slab Three Sides U",
	shape_groups = {slab = 1},
	eighths = 3,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -7 / 16},
			{-0.5, -0.5, -7 / 16, 0.5, -7 / 16, 7 / 16},
			{-0.5, -0.5, 7 / 16, 0.5, 0.5, 0.5}
		},
	},
})
