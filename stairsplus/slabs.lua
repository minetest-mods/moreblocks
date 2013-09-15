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
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			local keys=placer:get_player_control()
			stairsplus_rotate_and_place(itemstack, placer, pointed_thing, keys["sneak"])
			return itemstack
		end
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
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			local keys=placer:get_player_control()
			stairsplus_rotate_and_place(itemstack, placer, pointed_thing, keys["sneak"])
			return itemstack
		end
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
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			local keys=placer:get_player_control()
			stairsplus_rotate_and_place(itemstack, placer, pointed_thing, keys["sneak"])
			return itemstack
		end
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
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			local keys=placer:get_player_control()
			stairsplus_rotate_and_place(itemstack, placer, pointed_thing, keys["sneak"])
			return itemstack
		end
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

