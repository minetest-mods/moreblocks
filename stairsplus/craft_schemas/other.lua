local api = stairsplus.api
local register_craft_schema = api.register_craft_schema

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

-- slabs

register_craft_schema({
	type = "shapeless",
	output = "slab_8",
	recipe = {"micro_8", "micro_8", "micro_8", "micro_8"},
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
	output = "slab_4 2",
	recipe = {"slab_1", "slab_1", "slab_1", "slab_1"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_12",
	recipe = {"slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2"},
})

register_craft_schema({
	type = "shapeless",
	output = "slab_14",
	recipe = {"slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2"},
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
	recipe = {"slab_4", "slab_4", "slab_4", "slab_4"},
})

register_craft_schema({
	type = "shapeless",
	output = "node",
	recipe = {"slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2", "slab_2"},
})
