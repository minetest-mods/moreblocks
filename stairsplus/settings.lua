local s = minetest.settings

stairsplus.settings = {
	in_creative_inventory = s:get_bool("stairsplus.in_creative_inventory",
		s:get_bool("stairsplus_in_creative_inventory", false)  -- turn to false because we will do nicer things
	),
	circular_saw_crafting = s:get_bool("stairsplus.circular_saw_crafting", true),
	ex_nihilo = s:get_bool("stairsplus.ex_nihilo",
		s:get_bool("creative_mode", false)
	),

	default_align_style = s:get("stairsplus.default_align_style") or "user",

	legacy_mode = s:get_bool("stairsplus.legacy_mode", true),
	legacy_place_mechanic = s:get_bool("stairsplus.legacy_place_mechanic", true),
}
