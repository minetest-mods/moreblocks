--[[
More Blocks: slab definitions

Copyright (c) 2011-2018 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

-- Node will be called <modname>:slab_<subname>

function register_slab(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_slab(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_slab_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["slab"])
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":slab_" .. subname_old .. alternate, modname_new .. ":slab_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slab_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["slab"])
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":slab_" .. subname_old .. alternate, modname_new .. ":slab_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slab(modname, subname, recipeitem, fields)
	local defs = table.copy(stairsplus.defs["slab"])
	local desc_base = S("%s Slab"):format(fields.description)
	for alternate, shape in pairs(defs) do
		stairsplus.register_single("slab", alternate, shape, modname, subname, recipeitem, fields, moreblocks.config.stairsplus_slabs_not_in_creative_inventory)
	end

	circular_saw.known_nodes[recipeitem] = {modname, subname}
end
