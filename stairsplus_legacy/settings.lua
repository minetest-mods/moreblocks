local s = minetest.settings

stairsplus_legacy.settings = {
	basic_materials = s:get_bool("stairsplus_legacy.basic_materials", true),
	default = s:get_bool("stairsplus_legacy.default", true),
	farming = s:get_bool("stairsplus_legacy.farming", true),
	gloopblocks = s:get_bool("stairsplus_legacy.gloopblocks", true),
	technic = s:get_bool("stairsplus_legacy.technic", true),
	prefab = s:get_bool("stairsplus_legacy.prefab", true),
	wool = s:get_bool("stairsplus_legacy.wool", true),
}
