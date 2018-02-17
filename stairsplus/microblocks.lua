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

function stairsplus:register_micro_xdecor_alias(modname_old, subname_old, modname_new, subname_new, force)
	if not(minetest.settings:get_bool("moreblocks.conversion_xdecor>moreblocks")) then
		return
	end
	minetest.register_lbm({
		name = ":replace_xdecor_mano_cube_" .. modname_old .. "_" .. string.lower(subname_old) .. "_" .. stairsplus:uppercase_index_string(subname_old) .. "_" .. 
			modname_new .."_" .. string.lower(subname_new) .. stairsplus:uppercase_index_string(subname_new) .. string.gsub(minetest.serialize(force),"return ", "_"),
		nodenames = {modname_old .. ":" .. subname_old .. "_nanoslab", modname_old .. ":" .. subname_old .."_cube"},
		run_at_every_load = false,
		action = function(pos, node)
			local nodename
			if modname_old .. ":" .. subname_old .. "_nanoslab" == node.name then
				nodename = modname_new .. ":micro_" .. subname_new .. "_1"
			else
				nodename = modname_new .. ":micro_" .. subname_new
			end
			if node.param2 == 0 or node.param2%4 == 0 then
				minetest.set_node(pos, {name = nodename, param2 = node.param2+3})
			else
				minetest.set_node(pos, {name = nodename, param2 = node.param2-1})
			end
		end,
	})
end

function register_micro_alias_and_force(modname_old, subname_old, modname_new, subname_new, force)
	local stairsplus_alias = stairsplus:normal_alias_or_force(force)
	local defs = stairsplus.copytable(microblocks_defs)
	for alternate, def in pairs(defs) do
		stairsplus_alias(modname_old .. ":micro_" .. subname_old .. alternate, modname_new .. ":micro_" .. subname_new .. alternate)
	end
	stairsplus:register_micro_xdecor_alias(modname_old, subname_old, modname_new, subname_new, force)
	
end

function stairsplus:register_micro_alias(modname_old, subname_old, modname_new, subname_new)
	register_micro_alias_and_force(modname_old, subname_old, modname_new, subname_new, false)
end

function stairsplus:register_micro_alias_force(modname_old, subname_old, modname_new, subname_new)
	register_micro_alias_and_force(modname_old, subname_old, modname_new, subname_new, true)
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
	stairsplus:register_micro_xdecor_alias(modname, subname, modname, subname, false)

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
