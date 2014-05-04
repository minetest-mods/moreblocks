-- Load translation library if intllib is installed

local S
if intllib then
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function(s) return s end
end

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
		[""] = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		},
		["_quarter"] = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			},
		},
		["_three_quarter"] = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
			},
		},
		["_1"] = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			},
		},
		["_2"] = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
			},
		},
		["_14"] = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},
			},
		},
		["_15"] = {
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
			},
		},
	}
	local desc = S("%s Slab"):format(fields.description)
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
			def.drop = modname..":slab_"..fields.drop..alternate
		end
		minetest.register_node(":"..modname..":slab_"..subname..alternate, def)
	end
	minetest.register_alias("stairs:slab_"..subname, modname..":slab_"..subname)

	-- Some saw-less recipe.

		minetest.register_craft({
			output = "moreblocks:slab_" .. subname .. " 6",
			recipe = {
				{recipeitem, recipeitem, recipeitem},
			},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:slab_" .. subname,
			recipe = {"moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:slab_" .. subname,
			recipe = {"moreblocks:panel_" .. subname, "moreblocks:panel_" .. subname},
		})
end

