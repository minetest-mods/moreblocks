stairsplus.settings = {
	in_creative_inventory = minetest.settings:get_bool("stairsplus.in_creative_inventory", false),
	circular_saw_crafting = minetest.settings:get_bool("stairsplus.circular_saw_crafting", true),
	expect_infinite_stacks = minetest.settings:get_bool("stairsplus.expect_infinite_stacks",
		minetest.settings:get_bool("creative_mode", false)
	),

	legacy_mode = minetest.settings:get_bool("stairsplus.legacy_mode", true),
}
