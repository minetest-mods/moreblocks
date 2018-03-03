--[[
More Blocks: microblock definitions

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

-- Node will be called <modname>:micro_<subname>

function register_micro(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_micro(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_micro_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["micro"])
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":micro_" .. subname_old .. alternate, modname_new .. ":micro_" .. subname_new .. alternate)
	end
end

function stairsplus:register_micro_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["micro"])
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":micro_" .. subname_old .. alternate, modname_new .. ":micro_" .. subname_new .. alternate)
	end
end

function stairsplus:register_micro(modname, subname, recipeitem, fields)
	local defs = table.copy(stairsplus.defs["micro"])
	for alternate, def in pairs(defs) do
		stairsplus.register_single("micro", alternate, def, modname, subname, recipeitem, fields)
	end
	minetest.register_alias(modname.. ":micro_" ..subname.. "_bottom", modname.. ":micro_" ..subname)

	circular_saw.known_nodes[recipeitem] = {modname, subname}

	-- Some saw-less recipes:

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":micro_" .. subname .. " 7",
		recipe = {modname .. ":stair_" .. subname .. "_inner"},
	})

	minetest.register_craft({
	output = modname .. ":micro_" .. subname .. " 6",
		type = "shapeless",
	recipe = {modname .. ":stair_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":micro_" .. subname .. " 5",
		recipe = {modname .. ":stair_" .. subname .. "_outer"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":micro_" .. subname .. " 4",
		recipe = {modname .. ":slab_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":micro_" .. subname .. " 4",
		recipe = {modname .. ":stair_" .. subname .. "_alt"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":micro_" .. subname .. " 3",
		recipe = {modname .. ":stair_" .. subname .. "_right_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":micro_" .. subname .. " 2",
		recipe = {modname .. ":panel_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
	})
end
