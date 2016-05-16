--[[
More Blocks: node definitions

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

local sound_wood = default.node_sound_wood_defaults()
local sound_stone = default.node_sound_stone_defaults()
local sound_glass = default.node_sound_glass_defaults()
local sound_leaves = default.node_sound_leaves_defaults()

local function tile_tiles(name)
	local tex = "moreblocks_" ..name.. ".png"
	return {tex, tex, tex, tex, tex.. "^[transformR90", tex.. "^[transformR90"}
end

local nodes = {
	["wood_tile"] = {
		description = S("Mattonella di legno"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = {"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90"},
		sounds = sound_wood,
	},
	["wood_tile_flipped"] = {
		description = S("Mattonella di legno"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = {"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR180",
		"default_wood.png^moreblocks_wood_tile.png^[transformR180"},
		sounds = sound_wood,
		no_stairs = true,
	},
	["wood_tile_center"] = {
		description = S("Mattonella di legno centrata"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = {"default_wood.png^moreblocks_wood_tile_center.png"},
		sounds = sound_wood,
	},
	["wood_tile_full"] = {
		description = S("Mattonella di legno pieno"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = tile_tiles("wood_tile_full"),
		sounds = sound_wood,
	},
	["wood_tile_up"] = {
		description = S("Mattonella di legno rivolta in alto"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = {"default_wood.png^moreblocks_wood_tile_up.png"},
		sounds = sound_wood,
		no_stairs = true,
	},
	["wood_tile_down"] = {
		description = S("Mattonella di legno rivolta in basso"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = {"default_wood.png^[transformR180^moreblocks_wood_tile_up.png^[transformR180"},
		sounds = sound_wood,
		no_stairs = true,
	},
	["wood_tile_left"] = {
		description = S("Mattonella di legno rivolta a sinistra"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = {"default_wood.png^[transformR270^moreblocks_wood_tile_up.png^[transformR270"},
		sounds = sound_wood,
		no_stairs = true,
	},
	["wood_tile_right"] = {
		description = S("Mattonella di legno rivolta a destra"),
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		tiles = {"default_wood.png^[transformR90^moreblocks_wood_tile_up.png^[transformR90"},
		sounds = sound_wood,
		no_stairs = true,
	},
	["circle_stone_bricks"] = {
		description = S("Mattoni di pietra concentrici"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["grey_bricks"] = {
		description = S("Mattoni di pietra"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["coal_stone_bricks"] = {
		description = S("Mattoni in pietra di carbone"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["iron_stone_bricks"] = {
		description = S("Mattoni in pietra di ferro"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["stone_tile"] = {
		description = S("Mattonella di pietra"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["split_stone_tile"] = {
		description = S("Mattonella di pietra divisa"),
		tiles = {"moreblocks_split_stone_tile_top.png",
			"moreblocks_split_stone_tile.png"},
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["split_stone_tile_alt"] = {
		description = S("Mattonella di pietra a scacchi"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["tar"] = {
		description = S("Catrame"),
		groups = {cracky = 2, tar_block = 1},
		sounds = sound_stone,
	},
	["cobble_compressed"] = {
		description = S("Ciottoli compatti"),
		groups = {cracky = 1},
		sounds = sound_stone,
	},
	["plankstone"] = {
		description = S("Pietra e assi"),
		groups = {cracky = 3},
		tiles = tile_tiles("plankstone"),
		sounds = sound_stone,
	},
	["iron_glass"] = {
		description = S("Vetro e ferro"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_iron_glass.png", "moreblocks_iron_glass_detail.png"},
		tiles = {"moreblocks_iron_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
	["coal_glass"] = {
		description = S("Vetro e carbone"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_coal_glass.png", "moreblocks_coal_glass_detail.png"},
		tiles = {"moreblocks_coal_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
	["clean_glass"] = {
		description = S("Vetro pulito"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_clean_glass.png", "moreblocks_clean_glass_detail.png"},
		tiles = {"moreblocks_clean_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
	["cactus_brick"] = {
		description = S("Mattone di cactus"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["cactus_checker"] = {
		description = S("Scacchi di cactus"),
		groups = {cracky = 3},
		tiles = {"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png^[transformR90",
		"default_stone.png^moreblocks_cactus_checker.png^[transformR90"},
		sounds = sound_stone,
	},
	["empty_bookshelf"] = {
		description = S("Libreria vuota"),
		tiles = {"default_wood.png", "default_wood.png",
			"moreblocks_empty_bookshelf.png"},
		groups = {snappy = 2, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		sounds = sound_wood,
		no_stairs = true,
	},
	["coal_stone"] = {
		description = S("Pietra di carbone"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["iron_stone"] = {
		description = S("Pietra di ferro"),
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["coal_checker"] = {
		description = S("Scacchi di carbone"),
		tiles = {"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png^[transformR90",
		"default_stone.png^moreblocks_coal_checker.png^[transformR90"},
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["iron_checker"] = {
		description = S("Scacchi di ferro"),
		tiles = {"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png^[transformR90",
		"default_stone.png^moreblocks_iron_checker.png^[transformR90"},
		groups = {cracky = 3},
		sounds = sound_stone,
	},
	["trap_stone"] = {
		description = S("Pietra trappola"),
		walkable = false,
		groups = {cracky = 3},
		sounds = sound_stone,
		no_stairs = true,
	},
	["trap_glass"] = {
		description = S("Vetro trappola"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_trap_glass.png", "default_glass_detail.png"},
		tiles = {"moreblocks_trap_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
		no_stairs = true,
	},

--[[
	["fence_jungle_wood"] = {
		description = S("Jungle Wood Fence"),
		drawtype = "fencelike",
		tiles = {"default_junglewood.png"},
		inventory_image = "default_fence_overlay.png^default_junglewood.png^default_fence_overlay.png^[makealpha:255,126,126",
		wield_image = "default_fence_overlay.png^default_junglewood.png^default_fence_overlay.png^[makealpha:255,126,126",
		paramtype = "light",
		selection_box = {
			type = "fixed",
			fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
		},
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = sound_wood,
		no_stairs = true,
	},
]]--	
	
	
	["all_faces_tree"] = {
		description = S("Albero su ogni faccia"),
		tiles = {"default_tree_top.png"},
		groups = {tree = 1,snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = sound_wood,
		furnace_burntime = 30,
	},
	["all_faces_jungle_tree"] = {
		description = S("Albero della giungla su ogni faccia"),
		tiles = {"default_jungletree_top.png"},
		groups = {tree = 1,snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = sound_wood,
		furnace_burntime = 30,
	},
	["glow_glass"] = {
		description = S("Vetro splendente"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_glow_glass.png", "moreblocks_glow_glass_detail.png"},
		tiles = {"moreblocks_glow_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 11,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
	["trap_glow_glass"] = {
		description = S("Vetro splendente trappola"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_trap_glass.png", "moreblocks_glow_glass_detail.png"},
		tiles = {"moreblocks_trap_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 11,
		walkable = false,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
		no_stairs = true,
	},
	["super_glow_glass"] = {
		description = S("Super vetro splendente"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_super_glow_glass.png", "moreblocks_super_glow_glass_detail.png"},
		tiles = {"moreblocks_super_glow_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 15,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
	},
	["trap_super_glow_glass"] = {
		description = S("Super vetro splendente trappola"),
		drawtype = "glasslike_framed_optional",
		--tiles = {"moreblocks_trap_super_glow_glass.png", "moreblocks_super_glow_glass_detail.png"},
		tiles = {"moreblocks_trap_super_glow_glass.png"},
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 15,
		walkable = false,
		groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
		sounds = sound_glass,
		no_stairs = true,
	},
	["rope"] = {
		description = S("Corda"),
		drawtype = "signlike",
		inventory_image = "moreblocks_rope.png",
		wield_image = "moreblocks_rope.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		walkable = false,
		climbable = true,
		selection_box = {type = "wallmounted",},
		groups = {snappy = 3, flammable = 2},
		sounds = sound_leaves,
		no_stairs = true,
	},
}

for name, def in pairs(nodes) do
	def.tiles = def.tiles or {"moreblocks_" ..name.. ".png"}
	minetest.register_node("moreblocks:" ..name, def)
	minetest.register_alias(name, "moreblocks:" ..name)
	if not def.no_stairs then
		local groups = {}
		for k, v in pairs(def.groups) do groups[k] = v end
		stairsplus:register_all("moreblocks", name, "moreblocks:" ..name, {
			description = def.description,
			groups = groups,
			tiles = def.tiles,
			sunlight_propagates = def.sunlight_propagates,
			light_source = def.light_source,
			sounds = def.sounds,
		})
	end
end


-- Items

minetest.register_craftitem("moreblocks:sweeper", {
	description = S("Spazzola"),
	inventory_image = "moreblocks_sweeper.png",
})

minetest.register_craftitem("moreblocks:jungle_stick", {
	description = S("Bastone di legno della giungla"),
	inventory_image = "moreblocks_junglestick.png",
	groups = {stick= 1},
})

minetest.register_craftitem("moreblocks:nothing", {
	inventory_image = "invisible.png",
	on_use = function() end,
})

