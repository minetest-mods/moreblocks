-- Load translation library if intllib is installed

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
	else
	S = function ( s ) return s end
end

-- Node will be called <modname>slab_<subname>

function register_slab(modname, subname, recipeitem, groups, images, description, drop, light)

	minetest.register_node(":" .. modname .. ":slab_" .. subname, {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":slab_" .. drop,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":stairs:slab_" .. subname, {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		drop = modname .. ":slab_" .. drop,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":"..modname .. ":slab_" .. subname .. "_quarter", {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":slab_" .. drop .. "_quarter",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":"..modname .. ":slab_" .. subname .. "_three_quarter", {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":slab_" .. drop .. "_three_quarter",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":slab_" .. subname .. "_1", {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":slab_" .. drop .. "_1",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":slab_" .. subname .. "_2", {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":slab_" .. drop .. "_2",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":slab_" .. subname .. "_14", {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":slab_" .. drop .. "_14",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":"..modname .. ":slab_" .. subname .. "_15", {
		description = S("%s Slab"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":slab_" .. drop .. "_15",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	-- Unregister default recipes, optional, see _config.txt

if allow_stair_slab_crafting == false
then
	minetest.register_craft({
		output = "moreblocks:nothing 1",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end
end

