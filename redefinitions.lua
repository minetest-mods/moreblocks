-- Redefinitions of some default crafting recipes:

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

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.15, -- Tool repair buff (15% bonus instead of 2%).
})

-- Redefinitions of some default nodes:

 -- Don't bother overriding nodes if minetest.override_item isn't available.
if minetest.override_item then

if moreblocks.config.wood_facedir then
	minetest.override_item("default:wood", {
		paramtype2 = "facedir",
	})
	minetest.override_item("default:junglewood", {
		paramtype2 = "facedir",
	})
	minetest.override_item("default:brick", {
		paramtype2 = "facedir",
	})
	minetest.override_item("default:stonebrick", {
		paramtype2 = "facedir",
	})
	minetest.override_item("default:desert_stonebrick", {
		paramtype2 = "facedir",
	})
	minetest.override_item("default:sandstonebrick", {
		paramtype2 = "facedir",
	})
	minetest.override_item("moreblocks:cactus_brick", {
		paramtype2 = "facedir",
	})
	minetest.override_item("moreblocks:coal_stone_bricks", {
		paramtype2 = "facedir",
	})
	minetest.override_item("moreblocks:iron_stone_bricks", {
		paramtype2 = "facedir",
	})
end

-- Make glass and obsidian glass framed, like the More Blocks glasses:

minetest.override_item("default:glass", {
	drawtype = "glasslike_framed",
})

minetest.override_item("default:obsidian_glass", {
	drawtype = "glasslike_framed",
})

-- Let there be light. This makes some nodes let light pass through:

minetest.override_item("default:ladder", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:sapling", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:dry_shrub", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:papyrus", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:fence_wood", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:junglegrass", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:junglesapling", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:grass_1", {
	inventory_image = "default_grass_3.png", -- Use a bigger inventory image.
	wield_image = "default_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
})

for i = 2, 5 do
	minetest.override_item("default:grass_"..i, {
		paramtype = "light",
		sunlight_propagates = true,
	})
end

end -- End "if minetest.override_item".

