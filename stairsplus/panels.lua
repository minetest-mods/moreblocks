--[[
More Blocks: panel definitions

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

-- Node will be called <modname>:panel_<subname>

function register_panel(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_panel(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

local panels_defs = {
	[""] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
	},
	["_1"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
		},
	},
	["_2"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
		},
	},
	["_4"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, -0.25, 0.5},
		},
	},
	["_12"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.25, 0.5},
		},
	},
	["_14"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.375, 0.5},
		},
	},
	["_15"] = {
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.4375, 0.5},
		},
	}
}

for k,v in pairs(panels_defs) do
	table.insert(stairsplus.shapes_list, { "panel_", k })
end

function stairsplus:register_panel_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(panels_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":panel_" .. subname_old .. alternate, modname_new .. ":panel_" .. subname_new .. alternate)
	end
end

function stairsplus:register_panel_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(panels_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":panel_" .. subname_old .. alternate, modname_new .. ":panel_" .. subname_new .. alternate)
	end
end

function stairsplus:register_panel(modname, subname, recipeitem, fields)
	local defs = stairsplus.copytable(panels_defs)
	local desc = S("%s Panel"):format(fields.description)
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
			def.drop = modname.. ":panel_" ..fields.drop..alternate
		end
		minetest.register_node(":" ..modname.. ":panel_" ..subname..alternate, def)
	end
	minetest.register_alias(modname.. ":panel_" ..subname.. "_bottom", modname.. ":panel_" ..subname)

	circular_saw.known_nodes[recipeitem] = {modname, subname}

	-- Some saw-less recipes:

	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. " 12",
		recipe = {
			{recipeitem, ""},
			{recipeitem, recipeitem},
		},
	})

	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. " 12",
		recipe = {
			{"", recipeitem},
			{recipeitem, recipeitem},
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":panel_" .. subname,
		recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
	})
end
