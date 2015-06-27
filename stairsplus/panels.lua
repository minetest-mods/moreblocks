--[[
More Blocks: panel definitions

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

-- Node will be called <modname>:panel_<subname>

function register_panel(modname, subname, recipeitem, groups, images, description, drop, light)
	return stairsplus:register_panel(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_panel(modname, subname, recipeitem, fields)
	local defs = {
		[""] = { -- 8/16 high (default panel)
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		["_1"] = { -- 1/16 high
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
			},
		},
		["_2"] = { -- 2/16 high
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
			},
		},
		["_4"] = { -- 4/16 high
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, -0.25, 0.5},
			},
		},
		["_12"] = { -- 12/16 high
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0.25, 0.5},
			},
		},
		["_14"] = { -- 14/16 high
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0.375, 0.5},
			},
		},
		["_15"] = { -- 15/16 high
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0.4375, 0.5},
			},
		}
	}

	local desc = S("%s Panel"):format(fields.description)
	for alternate, def in pairs(defs) do
		def.drawtype = "nodebox"
		def.paramtype = "light"
		def.paramtype2 = "facedir"
		def.on_place = minetest.rotate_node
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.description = desc
		if fields.drop then
			def.drop = modname.. ":panel_" ..fields.drop..alternate
		end
		minetest.register_node(":" ..modname.. ":panel_" ..subname..alternate, def)
	end
	minetest.register_alias(modname.. ":panel_" ..subname.. "_bottom", modname.. ":panel_" ..subname)
	
	-- Some saw-less recipes:

	-- 3 blocks shaped to stair -> 12 panels
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. " 12",
		recipe = {
			{recipeitem, ""},
			{recipeitem, recipeitem},
		},
	})
	
	-- mirrored rule from above
	minetest.register_craft({
		output = modname .. ":panel_" .. subname .. " 12",
		recipe = {
			{"", recipeitem},
			{recipeitem, recipeitem},
		},
	})
	
	-- 2 microblocks -> panel
	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":panel_" .. subname,
		recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
	})
	
	-- 4 panels -> full block
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
	})
end
