-- Load translation library if intllib is installed

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
	else
	S = function ( s ) return s end
end

-- Node will be called <modname>:stair_<subname>

function register_stair(modname, subname, recipeitem, groups, images, description, drop, light)

	minetest.register_node(":" .. modname .. ":stair_" .. subname, {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":stairs:stair_" .. subname, {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":" .. modname .. ":stair_" .. subname .. "_half", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":"..modname .. ":stair_" .. subname .. "_right_half", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{0, -0.5, -0.5, 0.5, 0, 0.5},
				{0, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":"..modname .. ":stair_" .. subname .. "_inner", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":stair_" .. drop .. "_inner",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":"..modname .. ":stair_" .. subname .. "_outer", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":stair_" .. drop .. "_outer",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_node(":" .. modname .. ":stair_" .. subname .. "_alt", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":stair_" .. subname .. "_alt_1", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.0625, -0.5, 0.5, 0, 0},
				{-0.5, 0.4375, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":stair_" .. subname .. "_alt_2", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.5, 0.5, 0, 0},
				{-0.5, 0.375, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":stair_" .. subname .. "_alt_4", {
		description = S("%s Stairs"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.25, -0.5, 0.5, 0, 0},
				{-0.5, 0.25, 0, 0.5, 0.5, 0.5},
			},
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
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	minetest.register_craft({
		output = "moreblocks:nothing 1",
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end
end

