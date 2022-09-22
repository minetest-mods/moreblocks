local s = minetest.settings

stairsplus.settings = {
	circular_saw_crafting = s:get_bool("stairsplus.circular_saw_crafting", true),
	ex_nihilo = s:get_bool("stairsplus.ex_nihilo",
		s:get_bool("creative_mode", false)
	),

	in_creative_inventory = s:get_bool("stairsplus.in_creative_inventory",
		s:get_bool("moreblocks.stairsplus_in_creative_inventory", true)
	),
	in_craft_guide = s:get_bool("stairsplus.in_craft_guide", true),

	default_align_style = s:get("stairsplus.default_align_style") or "user",

	basic_shapes = string.split(s:get("stairsplus.common_shapes") or table.concat({
		"micro_8", "slab_8", "stair", "stair_inner", "stair_outer",
	}, ","), ","),
	common_shapes = string.split(s:get("stairsplus.common_shapes") or table.concat({
		"micro_8", "panel_8", "slab_1", "slab_8", "stair", "stair_inner", "stair_outer",
		"slope", "slope_half", "slope_half_raised", "slope_inner", "slope_inner_cut", "slope_inner_half",
		"slope_inner_cut_half", "slope_inner_half_raised", "slope_inner_cut_half_raised", "slope_outer",
		"slope_outer_cut", "slope_cut", "slope_outer_half", "slope_outer_cut_half", "slope_outer_half_raised",
		"slope_outer_cut_half_raised",
	}, ","), ","),

	legacy_mode = s:get_bool("stairsplus.legacy_mode", true),
	legacy_place_mechanic = s:get_bool("stairsplus.legacy_place_mechanic", true),

	crafting_schemata_enabled = s:get_bool("stairsplus.crafting_schemata_enabled", true),
}
