-- group overrides for various other mods

-- various things found in the wild
stairsplus.api.register_passthrough_groups({
	"bendy",
	"dig_generic",
	"dig_sand",
	"dig_stone",
	"dig_tree",
	"fast_travel",
	"melty",
	"unbreakable",
})

stairsplus.api.register_ignore_groups({
	"type_node",
	"ud_param2_colorable",
})

-- mineclone
stairsplus.api.register_passthrough_groups({
	"pickaxey",
	"axey",
	"shovely",
	"swordy",
	"swordy_cobweb",
	"shearsy",
	"shearsy_wool",
	"handy",
	"creative_breakable",
	"dig_by_water",
	"destroy_by_lava_flow",
	"dig_by_piston",
	"non_mycelium_plant",
	"enderman_takable",
	"disable_suffocation",
	"no_rename",
})

stairsplus.api.register_scaling_groups({
	"falling_node_damage",
	"fire_encouragement",
	"fire_flammability",
	"comparator_signal",
	"set_on_fire",
	"compostability",
})

stairsplus.api.register_ignore_groups({
	"crush_after_fall",
	"cultivatable",
	"path_creation_possible",
	"spreading_dirt_type",
	"dirtifies_below_solid",
	"dirtifier",
	"destroys_items",
	"no_eat_delay",
	"can_eat_when_full",
	"attached_node_facedir",
	"supported_node",
})
