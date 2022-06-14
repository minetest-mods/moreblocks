stairsplus.api.register_shape("panel_1", {
	name_format = "panel_%s_1",
	description = "@1 1/16 Panel",
	shape_groups = {panel = 1, legacy = 1},
	eighths = 1,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
	},
})

stairsplus.api.register_shape("panel_2", {
	name_format = "panel_%s_2",
	description = "@1 1/8 Panel",
	shape_groups = {panel = 1, legacy = 1},
	eighths = 1,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
	},
})

stairsplus.api.register_shape("panel_4", {
	name_format = "panel_%s_4",
	description = "@1 1/4 Panel",
	shape_groups = {panel = 1, legacy = 1},
	eighths = 1,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, -0.25, 0.5},
	},
})

stairsplus.api.register_shape("panel_8", {
	name_format = "panel_%s_8",
	aliases = {"panel_%s", "panel_bottom_%s"},
	description = "@1 1/2 Panel",
	shape_groups = {panel = 1, common = 1, legacy = 1},
	eighths = 2,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
	},
})

stairsplus.api.register_shape("panel_12", {
	name_format = "panel_%s_12",
	description = "@1 3/4 Panel",
	shape_groups = {panel = 1, legacy = 1},
	eighths = 3,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.25, 0.5},
	},
})

stairsplus.api.register_shape("panel_14", {
	name_format = "panel_%s_14",
	description = "@1 7/8 Panel",
	shape_groups = {panel = 1, legacy = 1},
	eighths = 4,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.375, 0.5},
	},
})

stairsplus.api.register_shape("panel_15", {
	name_format = "panel_%s_15",
	description = "@1 15/16 Panel",
	shape_groups = {panel = 1, legacy = 1},
	eighths = 4,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.4375, 0.5},
	},
})
