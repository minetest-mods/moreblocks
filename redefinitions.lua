-- Redefinitions of some default crafting recipes

minetest.register_craft({
	output = "default:sign_wall 4",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
		{"", "default:stick", ""},
	}
})

minetest.register_craft({
	output = "default:ladder 3",
	recipe = {
		{"default:stick", "", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

minetest.register_craft({
	output = "default:paper 3",
	recipe = {
		{"default:papyrus", "default:papyrus", "default:papyrus"},
	}
})

minetest.register_craft({
	output = "default:rail 16",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:stick", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "default:axe_wood",
	recipe = {
		{"default:wood", "default:wood"},
		{"default:stick", "default:wood"},
		{"default:stick", ""},
	}
})

minetest.register_craft({
	output = "default:axe_stone",
	recipe = {
		{"default:cobble", "default:cobble"},
		{"default:stick", "default:cobble"},
		{"default:stick", ""},
	}
})

minetest.register_craft({
	output = "default:axe_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:stick", "default:steel_ingot"},
		{"default:stick", ""},
	}
})

-- Tool repair buff (15% bonus instead of 2%)

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.15,
})

-- Redefinitions of some default nodes

minetest.register_node(":default:ladder", {
	description = "Ladder",
	drawtype = "signlike",
	tiles = {"default_ladder.png"},
	inventory_image = "default_ladder.png",
	wield_image = "default_ladder.png",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=3,flammable=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

if wood_facedir == true
then
minetest.register_node(":default:wood", {
	description = "Wooden Planks",
	tiles = {"default_wood.png"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})
end

minetest.register_node(":default:sapling", {
	description = "Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_sapling.png"},
	inventory_image = "default_sapling.png",
	wield_image = "default_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node(":default:dry_shrub", {
	description = "Dry Shrub",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_dry_shrub.png"},
	inventory_image = "default_dry_shrub.png",
	wield_image = "default_dry_shrub.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/3, -1/2, -1/3, 1/3, 1/6, 1/3},
	},
})

minetest.register_node(":default:papyrus", {
	description = "Papyrus",
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node(":default:fence_wood", {
	description = "Wooden Fence",
	drawtype = "fencelike",
	tiles = {"default_wood.png"},
	inventory_image = "default_fence.png",
	wield_image = "default_fence.png",
	paramtype = "light",
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node(":default:grass_1", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_1.png"},
	inventory_image = "default_grass_1.png",
	wield_image = "default_grass_1.png",
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("default:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:grass_1 " .. itemstack:get_count()-(1-ret:get_count()))
	end,
})

minetest.register_node(":default:grass_2", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_2.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drop = "default:grass_1",
	groups = {snappy=3,flammable=3,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})
minetest.register_node(":default:grass_3", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_3.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drop = "default:grass_1",
	groups = {snappy=3,flammable=3,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_node(":default:grass_4", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_4.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drop = "default:grass_1",
	groups = {snappy=3,flammable=3,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_node(":default:grass_5", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_5.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drop = "default:grass_1",
	groups = {snappy=3,flammable=3,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_node(":default:junglegrass", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	visual_scale = 1.25,
	tiles = {"default_junglegrass.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	groups = {snappy=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_node(":default:junglesapling", {
	description = "Jungle Sapling",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {"default_junglesapling.png"},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	sounds = default.node_sound_defaults(),
})
