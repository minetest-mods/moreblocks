--[[
More Blocks: slab definitions

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

-- Node will be called <modname>:slab_<subname>

function register_slab(modname, subname, recipeitem, groups, images, description, drop, light)
	return stairsplus:register_slab(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_slab(modname, subname, recipeitem, fields)
	local defs = {
		[""] = 8,
		["_quarter"] = 4,
		["_three_quarter"] = 12,
		["_1"] = 1,
		["_2"] = 2,
		["_14"] = 14,
		["_15"] = 15,
	}
	local desc_base = S("%s Slab"):format(fields.description)
	for alternate, num in pairs(defs) do
		local def = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, (num/16)-0.5, 0.5},
			}
		}
		def.drawtype = "nodebox"
		def.paramtype = "light"
		def.paramtype2 = "facedir"
		def.on_place = minetest.rotate_node
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.description = ("%s (%d/16)"):format(desc_base, num)
		if fields.drop then
			def.drop = modname.. ":slab_" .. fields.drop .. alternate
		end
		minetest.register_node(":" .. modname .. ":slab_" .. subname .. alternate, def)
	end
	minetest.register_alias("stairs:slab_" .. subname, modname .. ":slab_" .. subname)

	-- Some saw-less recipes:

		minetest.register_craft({
			output = modname .. ":slab_" .. subname .. " 6",
			recipe = {{recipeitem, recipeitem, recipeitem}},
		})
		
		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname,
			recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
		})
		
		minetest.register_craft({
			output = modname .. ":slab_" .. subname,
			recipe = {{modname .. ":panel_" .. subname, modname .. ":panel_" .. subname}},
		})
		
		minetest.register_craft({
			output = modname .. ":slab_" .. subname,
			recipe = {
				{modname .. ":panel_" .. subname},
				{modname .. ":panel_" .. subname},
			},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":slab_" .. subname, modname .. ":slab_" .. subname},
		})
		
		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. " 3",
			recipe = {modname .. ":stair_" .. subname, modname .. ":stair_" .. subname},
		})
end
