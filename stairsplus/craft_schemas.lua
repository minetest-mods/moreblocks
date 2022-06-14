local register_craft_schema = stairsplus.api.register_craft_schema

-- micros

---- micro_8

register_craft_schema({
	type = "shapeless",
	output = "micro_8 7",
	recipe = {"stair_inner"},
})

register_craft_schema({
	type = "shapeless",
	output = "micro_8 6",
	recipe = {"stair"},
})

register_craft_schema({
	type = "shapeless",
	output = "micro_8 5",
	recipe = {"stair_outer"},
})

register_craft_schema({
	type = "shapeless",
	output = "micro_8 4",
	recipe = {"slab_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "micro_8 4",
	recipe = {"stair_alt_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "micro_8 3",
	recipe = {"stair_right_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "micro_8 2",
	recipe = {"panel_8"},
})

-- panels

---- panel_8

register_craft_schema({
	output = "panel_8 12",
	recipe = {
		{"node", ""},
		{"node", "node"},
	},
})

register_craft_schema({
	output = "panel_8 12",
	recipe = {
		{"", "node"},
		{"node", "node"},
	},
})

register_craft_schema({
	type = "shapeless",
	output = "panel_8",
	recipe = {"micro_8", "micro_8"},
})

-- slabs

register_craft_schema({
	output = "slab_8 6",
	recipe = {{"node", "node", "node"}},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_8",
	recipe = {"micro_8", "micro_8", "micro_8", "micro_8"},
})

register_craft_schema({
	output = "slab_8",
	recipe = {{"panel_8", "panel_8"}},
})

register_craft_schema({
	output = "slab_8",
	recipe = {
		{"panel_8"},
		{"panel_8"},
	},
})
register_craft_schema({
	type = "shapeless",
	output = "slab_8 3",
	recipe = {"stair", "stair"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_8",
	recipe = {"slab_4", "slab_4"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_8",
	recipe = {"slab_2", "slab_2", "slab_2", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_8 2",
	recipe = {"slab_1", "slab_1", "slab_1", "slab_1", "slab_1", "slab_1", "slab_1", "slab_1"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_8",
	recipe = {"slope_half", "slope_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_8",
	recipe = {"slope_outer_half", "slope_inner_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_8",
	recipe = {"slope_outer_cut_half", "slope_inner_cut_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_4",
	recipe = {"slab_2", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_4 2",
	recipe = {"slab_1", "slab_1", "slab_1", "slab_1"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_12",
	recipe = {"slab_8", "slab_4"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_12",
	recipe = {"slab_4", "slab_4", "slab_4"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_12",
	recipe = {"slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_2 2",
	recipe = {"slab_1", "slab_1"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_14",
	recipe = {"slab_12", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_14",
	recipe = {"slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_15",
	recipe = {"slab_14", "slab_1"},
})

-- slopes

register_craft_schema({
	type = "shapeless",
	output = "slope_half_raised",
	recipe = {"slope_half", "slope_half", "slope_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "slope_half_raised",
	recipe = {"slab_8", "slope_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "slope_inner_half_raised",
	recipe = {"slab_8", "slope_inner_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "slope_outer_half_raised",
	recipe = {"slab_8", "slope_outer_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "slope_inner_cut_half_raised",
	recipe = {"slab_8", "slope_inner_cut_half"},
})

-- stairs

register_craft_schema({
	output = "stair 8",
	recipe = {
		{"node", "", ""},
		{"node", "node", ""},
		{"node", "node", "node"},
	},
})

register_craft_schema({
	output = "stair 8",
	recipe = {
		{"", "", "node"},
		{"", "node", "node"},
		{"node", "node", "node"},
	},
})

register_craft_schema({
	type = "shapeless",
	output = "stair",
	recipe = {"panel_8", "slab_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair",
	recipe = {"panel_8", "panel_8", "panel_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair",
	recipe = {"micro_8", "micro_8", "micro_8", "micro_8", "micro_8", "micro_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair",
	recipe = {"panel_8", "panel_8", "panel_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair_inner",
	recipe = {"micro_8", "micro_8", "micro_8", "micro_8", "micro_8", "micro_8", "micro_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair_outer",
	recipe = {"micro_8", "slab_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair_outer",
	recipe = {"micro_8", "micro_8", "micro_8", "micro_8", "micro_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair_half",
	recipe = {"micro_8", "micro_8", "micro_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair_half",
	recipe = {"panel_8", "micro_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "stair_right_half",
	recipe = {"stair_half"},
})

register_craft_schema({ -- See mirrored variation of the recipe below.
	output = "stair_alt_8",
	recipe = {
		{"panel_8", ""},
		{"", "panel_8"},
	},
})

register_craft_schema({ -- Mirrored variation of the recipe above.
	output = "stair_alt_8",
	recipe = {
		{"", "panel_8"},
		{"panel_8", ""},
	},
})

-- node

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"micro_8", "micro_8", "micro_8", "micro_8", "micro_8", "micro_8", "micro_8", "micro_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"panel_8", "panel_8", "panel_8", "panel_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slab_8", "slab_8"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slab_4", "slab_4", "slab_4", "slab_4"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slab_12", "slab_4"},
})
register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slab_14", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slab_15", "slab_1"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope", "slope"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_half", "slope_half_raised"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_half", "slope_half", "slope_half", "slope_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_outer", "slope_inner"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_outer_half", "slope_inner_half_raised"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_outer_half_raised", "slope_inner_half"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_outer_cut", "slope_inner_cut"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_outer_cut_half", "slope_inner_cut_half_raised"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slope_cut", "slope_cut"},
})
