local default_nodes = { -- Default stairs/slabs/panels/microblocks:
	"acacia_tree",
	"acacia_wood",
	"aspen_tree",
	"aspen_wood",
	"brick",
	"bronzeblock",
	"cobble",
	"copperblock",
	"coral_skeleton",
	"default:ice",
	"desert_cobble",
	"desert_sandstone",
	"desert_sandstone_block",
	"desert_sandstone_brick",
	"desert_stone",
	"desert_stone_block",
	"desert_stonebrick",
	"diamondblock",
	"goldblock",
	"ice",
	"jungletree",
	"junglewood",
	"meselamp",
	"mossycobble",
	"obsidian",
	"obsidian_block",
	"obsidianbrick",
	"pine_tree",
	"pine_wood",
	"sandstone",
	"sandstone_block",
	"sandstonebrick",
	"silver_sandstone",
	"silver_sandstone_block",
	"silver_sandstone_brick",
	"snowblock",
	"steelblock",
	"stone",
	"stone_block",
	"stonebrick",
	"tinblock",
	"tree",
	"wood",
}

for _, name in ipairs(default_nodes) do
	local node = ("default:%s"):format(name)
	if minetest.registered_nodes[node] then
		stairsplus_legacy.register_legacy(node)
		stairsplus.api.register_alias_all(("moreblocks:%s"):format(name), node)
		stairsplus.api.register_alias_all(("stairs:%s"):format(name), node)
	end
end

-- glass problems
local glass = {
	"glass",
	"obsidian_glass",
}

for _, name in ipairs(glass) do
	local node = ("default:%s"):format(name)
	if minetest.registered_nodes[node] then
		stairsplus_legacy.register_legacy(node, nil, {ignore_paramtype2 = true})
		stairsplus.api.register_alias_all(("moreblocks:%s"):format(name), node)
		stairsplus.api.register_alias_all(("stairs:%s"):format(name), node)
	end
end

if minetest.registered_nodes["default:glass"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "cooking",
		output = "default:glass",
		recipe = "group:sand",
	})
end

if minetest.registered_nodes["default:stone"] and minetest.registered_nodes["default:cobble"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "cooking",
		output = "default:stone",
		recipe = "default:cobble",
	})
end

if minetest.registered_nodes["default:stone"] and minetest.registered_nodes["default:mossycobble"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "cooking",
		output = "default:stone",
		recipe = "default:mossycobble",
	})
end

if minetest.registered_nodes["default:desert_stone"] and minetest.registered_nodes["default:desert_cobble"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "cooking",
		output = "default:desert_stone",
		recipe = "default:desert_cobble",
	})
end

stairsplus.api.register_crafts_for_shapes({
        type = "fuel",
        recipe = "group:tree",
        burntime = 30,
})

if minetest.registered_nodes["default:tree"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:tree",
		burntime = 30,
	})
end

if minetest.registered_nodes["default:aspen_tree"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:aspen_tree",
		burntime = 22,
	})
end

if minetest.registered_nodes["default:pine_tree"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:pine_tree",
		burntime = 26,
	})
end

if minetest.registered_nodes["default:acacia_tree"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:acacia_tree",
		burntime = 34,
	})
end

if minetest.registered_nodes["default:jungletree"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:jungletree",
		burntime = 38,
	})
end

stairsplus.api.register_crafts_for_shapes({
        type = "fuel",
        recipe = "group:wood",
        burntime = 7,
})

if minetest.registered_nodes["default:wood"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:wood",
		burntime = 7,
	})
end

if minetest.registered_nodes["default:aspen_wood"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:aspen_wood",
		burntime = 5,
	})
end

if minetest.registered_nodes["default:pine_wood"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:pine_wood",
		burntime = 6,
	})
end

if minetest.registered_nodes["default:acacia_wood"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:acacia_wood",
		burntime = 8,
	})
end

if minetest.registered_nodes["default:junglewood"] then
	stairsplus.api.register_crafts_for_shapes({
		type = "fuel",
		recipe = "default:junglewood",
		burntime = 9,
	})
end
