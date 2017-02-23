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

local microblocks_defs = {
	[""] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
		},
	},
	["_1"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, -0.4375, 0.5},
		},
	},
	["_2"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, -0.375, 0.5},
		},
	},
	["_4"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, -0.25, 0.5},
		},
	},
	["_12"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.25, 0.5},
		},
	},
	["_14"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.375, 0.5},
		},
	},
	["_15"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.4375, 0.5},
		},
	}
}

for k,v in pairs(microblocks_defs) do
	table.insert(stairsplus.shapes_list, { "micro_", k })
end

function stairsplus:register_micro_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(microblocks_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":micro_" .. subname_old .. alternate, modname_new .. ":micro_" .. subname_new .. alternate)
	end
end

function stairsplus:register_micro_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(microblocks_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":micro_" .. subname_old .. alternate, modname_new .. ":micro_" .. subname_new .. alternate)
	end
end

function stairsplus:register_micro(modname, subname, recipeitem, fields)
	local defs = stairsplus.copytable(microblocks_defs)
	local desc = S("%s Microblock"):format(fields.description)
	for alternate, def in pairs(defs) do
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.drawtype = "nodebox"
		def.paramtype = "light"
		def.paramtype2 = def.paramtype2 or "facedir"
		def.on_place = minetest.rotate_node
		def.groups = stairsplus:prepare_groups(fields.groups)
		def.description = desc
		if fields.drop and not (type(fields.drop) == "table") then
			def.drop = modname.. ":micro_" ..fields.drop..alternate
		end
		minetest.register_node(":" ..modname.. ":micro_" ..subname..alternate, def)
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
