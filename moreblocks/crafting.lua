--[[
More Blocks: crafting recipes

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]
local cm = moreblocks.resources.craft_materials

if cm.stick and cm.dry_shrub then
	minetest.register_craft({
		output = cm.stick,
		recipe = {{cm.dry_shrub}, }
	})
end

if cm.stick then
	minetest.register_craft({
		output = cm.stick,
		recipe = {{"group:sapling"}, }
	})
end

if cm.stick and cm.wood then
	minetest.register_craft({
		output = cm.wood,
		recipe = {
			{cm.stick, cm.stick},
			{cm.stick, cm.stick},
		}
	})
end

if cm.dirt_with_grass and cm.jungle_grass and cm.dirt then
	minetest.register_craft({
		output = cm.dirt_with_grass,
		type = "shapeless",
		recipe = {cm.jungle_grass, cm.dirt},
	})
end

if cm.mossy_cobble and cm.jungle_grass and cm.cobble then
	minetest.register_craft({
		output = cm.mossy_cobble,
		type = "shapeless",
		recipe = {cm.jungle_grass, cm.cobble},
	})
end

minetest.register_craft({
	output = "moreblocks:wood_tile 9",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

-- This must be registered after `moreblocks:wood_tile` to avoid recipe conflicts,
-- since `moreblocks:wood_tile` is part of `group:wood`
minetest.register_craft({
	output = "moreblocks:wood_tile_center 9",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "moreblocks:wood_tile", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile",
	recipe = {"moreblocks:wood_tile_flipped"}
})

minetest.register_craft({
	output = "moreblocks:wood_tile_full 4",
	recipe = {
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
	}
})

if cm.stick then
	minetest.register_craft({
		output = "moreblocks:wood_tile_offset",
		recipe = {
			{cm.stick},
			{"moreblocks:wood_tile_center"},
		}
	})
end

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_down"}
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_left"}
})

minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_right"}
})

if cm.stone and cm.coal_lump then
	minetest.register_craft({
		output = "moreblocks:circle_stone_bricks 5",
		recipe = {
			{"", cm.stone, ""},
			{cm.stone, cm.coal_lump, cm.stone},
			{"", cm.stone, ""},
		}
	})
end

if cm.jungle_grass and cm.stick then
	minetest.register_craft({
		output = "moreblocks:sweeper 4",
		recipe = {
			{cm.jungle_grass},
			{cm.stick},
		}
	})
end

if cm.cobble and cm.stone then
	minetest.register_craft({
		output = "moreblocks:stone_tile 9",
		recipe = {
			{cm.cobble, cm.cobble, cm.cobble},
			{cm.cobble, cm.stone, cm.cobble},
			{cm.cobble, cm.cobble, cm.cobble},
		}
	})
end

minetest.register_craft({
	output = "moreblocks:split_stone_tile",
	recipe = {
		{"moreblocks:stone_tile"},
	}
})

minetest.register_craft({
	output = "moreblocks:checker_stone_tile",
	recipe = {
		{"moreblocks:split_stone_tile"},
	}
})

-- When approaching the below craft, loop back to cobblestone, which can then be used to craft stone tiles again
if cm.cobble then
	minetest.register_craft({
		output = cm.cobble,
		recipe = {
			{"moreblocks:checker_stone_tile"},
		}
	})
end

if cm.stone and cm.brick then
	minetest.register_craft({
		output = "moreblocks:grey_bricks 2",
		type = "shapeless",
		recipe = {cm.stone, cm.brick},
	})
end

if cm.stone_brick and cm.brick then
	minetest.register_craft({
		output = "moreblocks:grey_bricks 2",
		type = "shapeless",
		recipe = {cm.stone_brick, cm.brick},
	})
end

if cm.bookshelf and cm.book then
	minetest.register_craft({
		output = "moreblocks:empty_shelf",
		type = "shapeless",
		recipe = {"moreblocks:sweeper", cm.bookshelf},
		replacements = {{cm.bookshelf, cm.book .. " 3"}},
		-- When obtaining an empty shelf, return the books used in it as well
	})
end

if cm.vessels_shelf and cm.glass_bottle then
	minetest.register_craft({
		output = "moreblocks:empty_shelf",
		type = "shapeless",
		recipe = {"moreblocks:sweeper", cm.vessels_shelf},
		replacements = {{cm.vessels_shelf, cm.glass_bottle .. " 3"}},
	})
end

if cm.book and cm.bookshelf then
	minetest.register_craft({
		type = "shapeless",
		output = cm.bookshelf,
		recipe = {"moreblocks:empty_shelf", cm.book, cm.book, cm.book},
	})
end

minetest.register_craft({
	output = "moreblocks:empty_shelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"", "", ""},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	output = "moreblocks:coal_stone_bricks 4",
	recipe = {
		{"moreblocks:coal_stone", "moreblocks:coal_stone"},
		{"moreblocks:coal_stone", "moreblocks:coal_stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:iron_stone_bricks 4",
	recipe = {
		{"moreblocks:iron_stone", "moreblocks:iron_stone"},
		{"moreblocks:iron_stone", "moreblocks:iron_stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"group:stone", "group:wood"},
		{"group:wood", "group:stone"},
	}
})

minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"group:wood", "group:stone"},
		{"group:stone", "group:wood"},
	}
})

if cm.coal_lump and cm.stone then
	minetest.register_craft({
		output = "moreblocks:coal_checker 4",
		recipe = {
			{cm.stone, cm.coal_lump},
			{cm.coal_lump, cm.stone},
		}
	})

	minetest.register_craft({
		output = "moreblocks:coal_checker 4",
		recipe = {
			{cm.coal_lump, cm.stone},
			{cm.stone, cm.coal_lump},
		}
	})
end

if cm.steel_ingot and cm.stone then
	minetest.register_craft({
		output = "moreblocks:iron_checker 4",
		recipe = {
			{cm.steel_ingot, cm.stone},
			{cm.stone, cm.steel_ingot},
		}
	})

	minetest.register_craft({
		output = "moreblocks:iron_checker 4",
		recipe = {
			{cm.stone, cm.steel_ingot},
			{cm.steel_ingot, cm.stone},
		}
	})
end

if cm.chest and cm.chest_locked then
	if cm.steel_ingot then
		minetest.register_craft({
			output = cm.chest_locked,
			type = "shapeless",
			recipe = {cm.steel_ingot, cm.chest},
		})
	end

	if cm.copper_ingot then
		minetest.register_craft({
			output = cm.chest_locked,
			type = "shapeless",
			recipe = {cm.copper_ingot, cm.chest},
		})
	end

	if cm.bronze_ingot then
		minetest.register_craft({
			output = cm.chest_locked,
			type = "shapeless",
			recipe = {cm.bronze_ingot, cm.chest},
		})
	end

	if cm.gold_ingot then
		minetest.register_craft({
			output = cm.chest_locked,
			type = "shapeless",
			recipe = {cm.gold_ingot, cm.chest},
		})
	end
end

if cm.glass and cm.steel_ingot then
	minetest.register_craft({
		output = "moreblocks:iron_glass",
		type = "shapeless",
		recipe = {cm.steel_ingot, cm.glass},
	})

	minetest.register_craft({
		output = cm.glass,
		type = "shapeless",
		recipe = {cm.steel_ingot, "moreblocks:coal_glass"},
	})
end

if cm.glass and cm.coal_lump then
	minetest.register_craft({
		output = cm.glass,
		type = "shapeless",
		recipe = {cm.coal_lump, "moreblocks:iron_glass"},
	})

	minetest.register_craft({
		output = "moreblocks:coal_glass",
		type = "shapeless",
		recipe = {cm.coal_lump, cm.glass},
	})
end

if cm.glass then
	minetest.register_craft({
		output = "moreblocks:clean_glass",
		type = "shapeless",
		recipe = {"moreblocks:sweeper", cm.glass},
	})
end

minetest.register_craft({
	output = "moreblocks:trap_clean_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:trap_glass"},
})

if cm.glass and cm.torch then
	minetest.register_craft({
		output = "moreblocks:glow_glass",
		type = "shapeless",
		recipe = {cm.torch, cm.glass},
	})
end

if cm.torch then
	minetest.register_craft({
		output = "moreblocks:clean_glow_glass",
		type = "shapeless",
		recipe = {cm.torch, "moreblocks:clean_glass"},
	})
end

minetest.register_craft({
	output = "moreblocks:clean_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:glow_glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:trap_glow_glass"},
})

if cm.torch and cm.glass then
	minetest.register_craft({
		output = "moreblocks:super_glow_glass",
		type = "shapeless",
		recipe = {cm.torch, cm.torch, cm.glass},
	})
end

if cm.torch then
	minetest.register_craft({
		output = "moreblocks:super_glow_glass",
		type = "shapeless",
		recipe = {cm.torch, "moreblocks:glow_glass"},
	})

	minetest.register_craft({
		output = "moreblocks:clean_super_glow_glass",
		type = "shapeless",
		recipe = {cm.torch, cm.torch, "moreblocks:clean_glass"},
	})

	minetest.register_craft({
		output = "moreblocks:clean_super_glow_glass",
		type = "shapeless",
		recipe = {cm.torch, "moreblocks:clean_glow_glass"},
	})
end

minetest.register_craft({
	output = "moreblocks:clean_super_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:super_glow_glass"},
})

minetest.register_craft({
	output = "moreblocks:trap_clean_super_glow_glass",
	type = "shapeless",
	recipe = {"moreblocks:sweeper", "moreblocks:trap_super_glow_glass"},
})

if cm.coal_lump and cm.stone then
	minetest.register_craft({
		output = "moreblocks:coal_stone",
		type = "shapeless",
		recipe = {cm.coal_lump, cm.stone},
	})

	minetest.register_craft({
		output = cm.stone,
		type = "shapeless",
		recipe = {cm.coal_lump, "moreblocks:iron_stone"},
	})
end

if cm.stone and cm.steel_ingot then
	minetest.register_craft({
		output = cm.stone,
		type = "shapeless",
		recipe = {cm.steel_ingot, "moreblocks:coal_stone"},
	})

	minetest.register_craft({
		output = "moreblocks:iron_stone",
		type = "shapeless",
		recipe = {cm.steel_ingot, cm.stone},
	})
end

if cm.cactus and cm.brick then
	minetest.register_craft({
		output = "moreblocks:cactus_brick",
		type = "shapeless",
		recipe = {cm.cactus, cm.brick},
	})
end

if cm.cactus and cm.stone then
	minetest.register_craft({
		output = "moreblocks:cactus_checker 4",
		recipe = {
			{cm.cactus, cm.stone},
			{cm.stone, cm.cactus},
		}
	})

	minetest.register_craft({
		output = "moreblocks:cactus_checker 4",
		recipe = {
			{cm.stone, cm.cactus},
			{cm.cactus, cm.stone},
		}
	})
end

if cm.jungle_grass then
	minetest.register_craft({
		output = "moreblocks:rope 3",
		recipe = {
			{cm.jungle_grass},
			{cm.jungle_grass},
			{cm.jungle_grass},
		}
	})
end

if cm.dirt then
	minetest.register_craft({
		output = "moreblocks:dirt_compressed",
		recipe = {
			{cm.dirt, cm.dirt, cm.dirt},
			{cm.dirt, cm.dirt, cm.dirt},
			{cm.dirt, cm.dirt, cm.dirt},
		}
	})

	minetest.register_craft({
		output = cm.dirt .. " 9",
		recipe = {{"moreblocks:dirt_compressed"}},
	})
end

if cm.cobble then
	minetest.register_craft({
		output = "moreblocks:cobble_compressed",
		recipe = {
			{cm.cobble, cm.cobble, cm.cobble},
			{cm.cobble, cm.cobble, cm.cobble},
			{cm.cobble, cm.cobble, cm.cobble},
		}
	})

	minetest.register_craft({
		output = cm.cobble .. " 9",
		recipe = {
			{"moreblocks:cobble_compressed"},
		}
	})
end

if cm.desert_cobble then
	minetest.register_craft({
		output = "moreblocks:desert_cobble_compressed",
		recipe = {
			{cm.desert_cobble, cm.desert_cobble, cm.desert_cobble},
			{cm.desert_cobble, cm.desert_cobble, cm.desert_cobble},
			{cm.desert_cobble, cm.desert_cobble, cm.desert_cobble},
		}
	})

	minetest.register_craft({
		output = cm.desert_cobble .. " 9",
		recipe = {
			{"moreblocks:desert_cobble_compressed"},
		}
	})
end

if cm.pine_tree then
	minetest.register_craft({
		type = "cooking", output = "moreblocks:tar", recipe = cm.pine_tree,
	})
end

if cm.copper_block and cm.bucket_empty then
	minetest.register_craft({
		type = "shapeless",
		output = "moreblocks:copperpatina",
		recipe = {"group:water_bucket", cm.copper_block},
		replacements = {
			{"group:water_bucket", cm.bucket_empty}
		}
	})
end

if cm.copper_block then
	minetest.register_craft({
		type = "shapeless",
		output = "moreblocks:copperpatina",
		recipe = {"group:water", cm.copper_block},
	})
end

if cm.copper_ingot then
	minetest.register_craft({
		output = cm.copper_ingot .. " 9",
		recipe = {
			{"moreblocks:copperpatina"},
		}
	})
end
