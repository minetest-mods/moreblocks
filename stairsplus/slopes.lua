--[[
More Blocks: slope definitions

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

local box_slope = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local box_slope_half = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -0.5,  0.5, -0.375, 0.5},
		{-0.5, -0.375, -0.25, 0.5, -0.25,  0.5},
		{-0.5, -0.25,  0,    0.5, -0.125, 0.5},
		{-0.5, -0.125, 0.25, 0.5,  0,     0.5},
	}
}

local box_slope_half_raised = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -0.5,  0.5, 0.125, 0.5},
		{-0.5, 0.125, -0.25, 0.5, 0.25,  0.5},
		{-0.5, 0.25,  0,    0.5, 0.375, 0.5},
		{-0.5, 0.375, 0.25, 0.5,  0.5,     0.5},
	}
}

--==============================================================

local box_slope_inner = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5},
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5},
		{-0.5, 0, -0.5, 0, 0.25, 0.5},
		{-0.5, 0, 0, 0.5, 0.25, 0.5},
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
	}
}

local box_slope_inner_half = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
		{-0.5, -0.375, -0.25, 0.5, -0.25, 0.5},
		{-0.5, -0.375, -0.5, 0.25, -0.25, 0.5},
		{-0.5, -0.25, -0.5, 0, -0.125, 0.5},
		{-0.5, -0.25, 0, 0.5, -0.125, 0.5},
		{-0.5, -0.125, 0.25, 0.5, 0, 0.5},
		{-0.5, -0.125, -0.5, -0.25, 0, 0.5},
	}
}

local box_slope_inner_half_raised = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
		{-0.5, 0.125, -0.25, 0.5, 0.25, 0.5},
		{-0.5, 0.125, -0.5, 0.25, 0.25, 0.5},
		{-0.5, 0.25, -0.5, 0, 0.375, 0.5},
		{-0.5, 0.25, 0, 0.5, 0.375, 0.5},
		{-0.5, 0.375, 0.25, 0.5, 0.5, 0.5},
		{-0.5, 0.375, -0.5, -0.25, 0.5, 0.5},
	}
}

--==============================================================

local box_slope_outer = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}

local box_slope_outer_half = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.375, 0.5},
		{-0.5, -0.375, -0.25,  0.25, -0.25, 0.5},
		{-0.5,  -0.25,     0,     0, -0.125, 0.5},
		{-0.5,  -0.125,  0.25, -0.25, 0, 0.5}
	}
}

local box_slope_outer_half_raised = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, 0.125, 0.5},
		{-0.5, 0.125, -0.25,  0.25, 0.25, 0.5},
		{-0.5,  0.25,     0,     0, 0.375, 0.5},
		{-0.5,  0.375,  0.25, -0.25, 0.5, 0.5}
	}
}

-- Node will be called <modname>:slope_<subname>

function register_slope(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_slope(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

local slopes_defs = {
	[""] = {
		mesh = "moreblocks_slope.obj",
		collision_box = box_slope,
		selection_box = box_slope,

	},
	["_half"] = {
		mesh = "moreblocks_slope_half.obj",
		collision_box = box_slope_half,
		selection_box = box_slope_half,
	},
	["_half_raised"] = {
		mesh = "moreblocks_slope_half_raised.obj",
		collision_box = box_slope_half_raised,
		selection_box = box_slope_half_raised,
	},

	--==============================================================

	["_inner"] = {
		mesh = "moreblocks_slope_inner.obj",
		collision_box = box_slope_inner,
		selection_box = box_slope_inner,
	},
	["_inner_half"] = {
		mesh = "moreblocks_slope_inner_half.obj",
		collision_box = box_slope_inner_half,
		selection_box = box_slope_inner_half,
	},
	["_inner_half_raised"] = {
		mesh = "moreblocks_slope_inner_half_raised.obj",
		collision_box = box_slope_inner_half_raised,
		selection_box = box_slope_inner_half_raised,
	},

	--==============================================================

	["_inner_cut"] = {
		mesh = "moreblocks_slope_inner_cut.obj",
		collision_box = box_slope_inner,
		selection_box = box_slope_inner,
	},
	["_inner_cut_half"] = {
		mesh = "moreblocks_slope_inner_cut_half.obj",
		collision_box = box_slope_inner_half,
		selection_box = box_slope_inner_half,
	},
	["_inner_cut_half_raised"] = {
		mesh = "moreblocks_slope_inner_cut_half_raised.obj",
		collision_box = box_slope_inner_half_raised,
		selection_box = box_slope_inner_half_raised,
	},

	--==============================================================

	["_outer"] = {
		mesh = "moreblocks_slope_outer.obj",
		collision_box = box_slope_outer,
		selection_box = box_slope_outer,
	},
	["_outer_half"] = {
		mesh = "moreblocks_slope_outer_half.obj",
		collision_box = box_slope_outer_half,
		selection_box = box_slope_outer_half,
	},
	["_outer_half_raised"] = {
		mesh = "moreblocks_slope_outer_half_raised.obj",
		collision_box = box_slope_outer_half_raised,
		selection_box = box_slope_outer_half_raised,
	},

	--==============================================================

	["_outer_cut"] = {
		mesh = "moreblocks_slope_outer_cut.obj",
		collision_box = box_slope_outer,
		selection_box = box_slope_outer,
	},
	["_outer_cut_half"] = {
		mesh = "moreblocks_slope_outer_cut_half.obj",
		collision_box = box_slope_outer_half,
		selection_box = box_slope_outer_half,
	},
	["_outer_cut_half_raised"] = {
		mesh = "moreblocks_slope_outer_cut_half_raised.obj",
		collision_box = box_slope_outer_half_raised,
		selection_box = box_slope_outer_half_raised,
	},
	["_cut"] = {
		mesh = "moreblocks_slope_cut.obj",
		collision_box = box_slope_outer,
		selection_box = box_slope_outer,
	},
}

for k,v in pairs(slopes_defs) do
	table.insert(stairsplus.shapes_list, { "slope_", k })
end

function stairsplus:register_slope_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(slopes_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":slope_" .. subname_old .. alternate, modname_new .. ":slope_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slope_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = stairsplus.copytable(slopes_defs)
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":slope_" .. subname_old .. alternate, modname_new .. ":slope_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slope(modname, subname, recipeitem, fields)
	local defs = stairsplus.copytable(slopes_defs)
	local desc = S("%s Slope"):format(fields.description)
	for alternate, def in pairs(defs) do
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.drawtype = "mesh"
		def.paramtype = "light"
		def.paramtype2 = def.paramtype2 or "facedir"
		def.on_place = minetest.rotate_node
		def.description = desc
		def.groups = stairsplus:prepare_groups(fields.groups)
		if fields.drop and not (type(fields.drop) == "table") then
			def.drop = modname.. ":slope_" ..fields.drop..alternate
		end
		minetest.register_node(":" ..modname.. ":slope_" ..subname..alternate, def)
	end

	circular_saw.known_nodes[recipeitem] = {modname, subname}

	-- Some saw-less recipes:

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname, modname .. ":slope_" .. subname},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half_raised"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half",
				   modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_outer", modname .. ":slope_" .. subname .. "_inner"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_outer_half", modname .. ":slope_" .. subname .. "_inner_half_raised"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_outer_half_raised", modname .. ":slope_" .. subname .. "_inner_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_outer_cut", modname .. ":slope_" .. subname .. "_inner_cut"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_outer_cut_half", modname .. ":slope_" .. subname .. "_inner_cut_half_raised"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_cut", modname .. ":slope_" .. subname .. "_cut"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slab_" .. subname,
		recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slab_" .. subname,
		recipe =  {modname .. ":slope_" .. subname .. "_outer_half", modname .. ":slope_" .. subname .. "_inner_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slab_" .. subname,
		recipe =  {modname .. ":slope_" .. subname .. "_outer_cut_half", modname .. ":slope_" .. subname .. "_inner_cut_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_half_raised",
		recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half",
				   modname .. ":slope_" .. subname .. "_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_half_raised",
		recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_inner_half_raised",
		recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_inner_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_outer_half_raised",
		recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_outer_half"},
	})

	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_inner_cut_half_raised",
		recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_inner_cut_half"},
	})
end
