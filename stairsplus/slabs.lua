--[[
More Blocks: slab definitions

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

-- Node will be called <modname>:slab_<subname>

function register_slab(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_slab(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

local slabs_defs = {
	[""] = 8,
	["_quarter"] = 4,
	["_three_quarter"] = 12,
	["_1"] = 1,
	["_2"] = 2,
	["_14"] = 14,
	["_15"] = 15,
	["_two_sides"] = {
						{ -0.5, -0.5, -0.5, 0.5, -7/16, 7/16 },
						{ -0.5, -0.5, 7/16, 0.5, 0.5, 0.5 }
					},
	["_three_sides"] = {
						{ -7/16, -0.5, -0.5, 0.5, -7/16, 7/16 },
						{ -7/16, -0.5, 7/16, 0.5, 0.5, 0.5 },
						{ -0.5, -0.5, -0.5, -7/16, 0.5, 0.5 }
					},
	["_three_sides_u"] = {
						{ -0.5, -0.5, -0.5, 0.5, 0.5, -7/16 },
						{ -0.5, -0.5, -7/16, 0.5, -7/16, 7/16 },
						{ -0.5, -0.5, 7/16, 0.5, 0.5, 0.5 }
					}
}

for k,v in pairs(slabs_defs) do
	table.insert(stairsplus.shapes_list, { "slab_", k })
end

function stairsplus:register_slab_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(slabs_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":slab_" .. subname_old .. alternate, modname_new .. ":slab_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slab_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(slabs_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":slab_" .. subname_old .. alternate, modname_new .. ":slab_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slab(modname, subname, recipeitem, fields)
	local defs = stairsplus.copytable(slabs_defs)
	local desc_base = S("%s Slab"):format(fields.description)
	for alternate, shape in pairs(defs) do

		local def = {}

		if type(shape) ~= "table" then
			def = {
					node_box = {
						type = "fixed",
						fixed = {-0.5, -0.5, -0.5, 0.5, (shape/16)-0.5, 0.5},
					},
					description = ("%s (%d/16)"):format(desc_base, shape)
				}
		else
			def = {
				node_box = {
					type = "fixed",
					fixed = shape,
				},
				description = desc_base
			}
		end

		for k, v in pairs(fields) do
			def[k] = v
		end

		def.drawtype = "nodebox"
		def.paramtype = "light"
		def.paramtype2 = def.paramtype2 or "facedir"
		def.on_place = minetest.rotate_node
		def.groups = stairsplus:prepare_groups(fields.groups)
		if fields.drop and not (type(fields.drop) == "table") then
			def.drop = modname.. ":slab_" .. fields.drop .. alternate
		end
		minetest.register_node(":" .. modname .. ":slab_" .. subname .. alternate, def)
	end
	minetest.register_alias("stairs:slab_" .. subname, modname .. ":slab_" .. subname)

	circular_saw.known_nodes[recipeitem] = {modname, subname}

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

		-- uncomment this rule when conflict is no longer likely to happen
		--	https://github.com/minetest/minetest/issues/2881
		-- minetest.register_craft({
		--	type = "shapeless",
		--	output = modname .. ":slab_" .. subname,
		--	recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
		-- })

		-- then remove these two
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
		------------------------------

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":slab_" .. subname, modname .. ":slab_" .. subname},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":slab_" .. subname .. "_three_quarter", modname .. ":slab_" .. subname .. "_quarter"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":slab_" .. subname .. "_14", modname .. ":slab_" .. subname .. "_2"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":slab_" .. subname .. "_15", modname .. ":slab_" .. subname .. "_1"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname,
			recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname,
			recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname,
			recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_quarter",
			recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_quarter",
			recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_2",
			recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_three_quarter",
			recipe = {modname .. ":slab_" .. subname, modname .. ":slab_" .. subname .. "_quarter"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_three_quarter",
			recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_three_quarter",
			recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_14",
			recipe = {modname .. ":slab_" .. subname .. "_three_quarter", modname .. ":slab_" .. subname .. "_2"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_14",
			recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. "_15",
			recipe = {modname .. ":slab_" .. subname .. "_14", modname .. ":slab_" .. subname .. "_1"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":slab_" .. subname .. " 3",
			recipe = {modname .. ":stair_" .. subname, modname .. ":stair_" .. subname},
		})
end
