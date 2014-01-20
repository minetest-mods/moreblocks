-- Load translation library if intllib is installed

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
	else
	S = function ( s ) return s end
end

-- Node will be called <modname>micro_<subname>

function register_micro(modname, subname, recipeitem, groups, images, description, drop, light)

	minetest.register_node(":"..modname .. ":micro_" .. subname, {
		description = S("%s Microblock"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":micro_" .. drop,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":micro_" .. subname .. "_1", {
		description = S("%s Microblock"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":micro_" .. drop .. "_1",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, -0.4375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":micro_" .. subname .. "_2", {
		description = S("%s Microblock"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":micro_" .. drop .. "_2",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, -0.375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":micro_" .. subname .. "_4", {
		description = S("%s Microblock"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":micro_" .. drop .. "_4",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, -0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":micro_" .. subname .. "_12", {
		description = S("%s Microblock"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":micro_" .. drop .. "_12",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":micro_" .. subname .. "_14", {
		description = S("%s Microblock"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":micro_" .. drop .. "_14",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":micro_" .. subname .. "_15", {
		description = S("%s Microblock"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":micro_" .. drop .. "_15",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.4375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_alias(modname..":micro_"..subname.."_bottom", modname..":micro_"..subname)
end

