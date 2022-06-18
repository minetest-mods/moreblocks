local api = stairsplus.api
local register_craft_schema = api.register_craft_schema

register_craft_schema({
	type = "shapeless",
	output = "slab_8 3",
	recipe = {"stair", "stair"},
})

register_craft_schema({
	type = "shapeless",
	output = "node 3",
	recipe = {"stair", "stair", "stair", "stair"},
})

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
	output = "stair_alt_1",
	recipe = {
		{"panel_1", ""},
		{"", "panel_1"},
	},
})

register_craft_schema({
	output = "stair_alt_1",
	recipe = {
		{"", "panel_1"},
		{"panel_1", ""},
	},
})

register_craft_schema({
	output = "stair_alt_2",
	recipe = {
		{"panel_2", ""},
		{"", "panel_2"},
	},
})

register_craft_schema({
	output = "stair_alt_2",
	recipe = {
		{"", "panel_2"},
		{"panel_2", ""},
	},
})

register_craft_schema({
	output = "stair_alt_4",
	recipe = {
		{"panel_4", ""},
		{"", "panel_4"},
	},
})

register_craft_schema({
	output = "stair_alt_4",
	recipe = {
		{"", "panel_4"},
		{"panel_4", ""},
	},
})

register_craft_schema({
	output = "stair_alt_8",
	recipe = {
		{"panel_8", ""},
		{"", "panel_8"},
	},
})

register_craft_schema({
	output = "stair_alt_8",
	recipe = {
		{"", "panel_8"},
		{"panel_8", ""},
	},
})
