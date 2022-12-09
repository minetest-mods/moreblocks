local s = minetest.settings

stairs.settings = {
	legacy_stairs_without_recipeitem = s:get_bool("stairs.legacy_stairs_without_recipeitem", false),
}
