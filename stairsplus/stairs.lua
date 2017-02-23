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

local stairs_defs = {
	[""] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
	},
	["_half"] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
	},
	["_right_half" ]= {
		node_box = {
			type = "fixed",
			fixed = {
				{0, -0.5, -0.5, 0.5, 0, 0.5},
				{0, 0, 0, 0.5, 0.5, 0.5},
			},
		},
	},
	["_inner"] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
	},
	["_outer"] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
	},
	["_alt"] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
	},
	["_alt_1"] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.0625, -0.5, 0.5, 0, 0},
				{-0.5, 0.4375, 0, 0.5, 0.5, 0.5},
			},
		},
	},
	["_alt_2"] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.5, 0.5, 0, 0},
				{-0.5, 0.375, 0, 0.5, 0.5, 0.5},
			},
		},
	},
	["_alt_4"] = {
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.25, -0.5, 0.5, 0, 0},
				{-0.5, 0.25, 0, 0.5, 0.5, 0.5},
			},
		},
	},
}

for k,v in pairs(stairs_defs) do
	table.insert(stairsplus.shapes_list, { "stair_", k })
end

function stairsplus:register_stair_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(stairs_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":stair_" .. subname_old .. alternate, modname_new .. ":stair_" .. subname_new .. alternate)
	end
end

function stairsplus:register_stair_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(stairs_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":stair_" .. subname_old .. alternate, modname_new .. ":stair_" .. subname_new .. alternate)
	end
end

function stairsplus:register_stair(modname, subname, recipeitem, fields)
	local defs = stairsplus.copytable(stairs_defs)
	local desc = S("%s Stairs"):format(fields.description)
	for alternate, def in pairs(defs) do
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.drawtype = "nodebox"
		def.paramtype = "light"
		def.paramtype2 = def.paramtype2 or "facedir"
		def.on_place = minetest.rotate_node
		def.description = desc
		def.groups = stairsplus:prepare_groups(fields.groups)
		if fields.drop and not (type(fields.drop) == "table") then
			def.drop = modname .. ":stair_" .. fields.drop .. alternate
		end
		minetest.register_node(":" .. modname .. ":stair_" .. subname .. alternate, def)
	end
	minetest.register_alias("stairs:stair_" .. subname, modname .. ":stair_" .. subname)

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
