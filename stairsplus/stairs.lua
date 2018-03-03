--[[
More Blocks: stair definitions

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

-- Node will be called <modname>:stair_<subname>

function register_stair(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_stair(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_stair_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["stair"])
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":stair_" .. subname_old .. alternate, modname_new .. ":stair_" .. subname_new .. alternate)
	end
end

function stairsplus:register_stair_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["stair"])
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":stair_" .. subname_old .. alternate, modname_new .. ":stair_" .. subname_new .. alternate)
	end
end

function stairsplus:register_stair(modname, subname, recipeitem, fields)
	local defs = table.copy(stairsplus.defs["stair"])
	for alternate, def in pairs(defs) do
		stairsplus.register_single("stair", alternate, def, modname, subname, recipeitem, fields)
	end

	circular_saw.known_nodes[recipeitem] = {modname, subname}

	-- Some saw-less recipes:

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. " 8",
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. " 8",
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname,
		recipe = {modname .. ":panel_" .. subname, modname .. ":slab_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname,
		recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname .. "_outer",
		recipe = {modname .. ":micro_" .. subname, modname .. ":slab_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname .. "_half",
		recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname .. "_half",
		recipe = {modname .. ":panel_" .. subname, modname .. ":micro_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname .. "_right_half",
		recipe = {modname .. ":stair_" .. subname .. "_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname,
		recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname .. "_inner",
		recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname .. "_outer",
		recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":stair_" .. subname,
		recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
	})

	minetest.register_craft({ -- See mirrored variation of the recipe below.
		output = modname .. ":stair_" .. subname .. "_alt",
		recipe = {
			{modname .. ":panel_" .. subname, ""},
			{""                            , modname .. ":panel_" .. subname},
		},
	})

	minetest.register_craft({ -- Mirrored variation of the recipe above.
		output = modname .. ":stair_" .. subname .. "_alt",
		recipe = {
			{""                            , modname .. ":panel_" .. subname},
			{modname .. ":panel_" .. subname, ""},
		},
	})
end
