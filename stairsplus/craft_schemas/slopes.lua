local api = stairsplus.api
local register_craft_schema = api.register_craft_schema

-- slopes

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
