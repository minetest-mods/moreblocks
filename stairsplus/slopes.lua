--[[
More Blocks: slope definitions

Copyright (c) 2011-2015 Calinou and contributors.
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
	return stairsplus:register_slope(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_slope(modname, subname, recipeitem, fields)
	local defs = {
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
	}

	local desc = S("%s Slope"):format(fields.description)
	for alternate, def in pairs(defs) do
		def.drawtype = "mesh"
		def.paramtype = "light"
		def.paramtype2 = "facedir"
		def.on_place = minetest.rotate_node
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.description = desc
		if fields.drop then
			def.drop = modname.. ":slope_" ..fields.drop..alternate
		end
		minetest.register_node(":" ..modname.. ":slope_" ..subname..alternate, def)
	end

	-- Some saw-less recipes:
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. " 7",
		recipe = {
			{modname .. ":panel_" .. subname, "", ""},
			{recipeitem, modname .. ":panel_" .. subname, ""},
			{recipeitem, recipeitem, modname .. ":panel_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. " 7",
		recipe = {
			{"", "", modname .. ":panel_" .. subname},
			{"", modname .. ":panel_" .. subname, recipeitem},
			{modname .. ":panel_" .. subname, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_half 10",
		recipe = {
			{modname .. ":panel_" .. subname, "", ""},
			{recipeitem, recipeitem, modname .. ":panel_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_half 10",
		recipe = {
			{"", "", modname .. ":panel_" .. subname},
			{modname .. ":panel_" .. subname, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_half_raised 7",
		recipe = {
			{modname .. ":panel_" .. subname, "", ""},
			{recipeitem, recipeitem, modname .. ":panel_" .. subname},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_half_raised 7",
		recipe = {
			{"", "", modname .. ":panel_" .. subname},
			{modname .. ":panel_" .. subname, recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
--===================================================== Inner ==

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_inner 7",
		recipe = {
			{modname .. ":stair_" .. subname .. "_half", "", ""},
			{recipeitem, modname .. ":stair_" .. subname .. "_half", ""},
			{recipeitem, recipeitem, modname .. ":stair_" .. subname .. "_half"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_inner 7",
		recipe = {
			{"", "", modname .. ":stair_" .. subname .. "_half"},
			{"", modname .. ":stair_" .. subname .. "_half", recipeitem},
			{modname .. ":stair_" .. subname .. "_half", recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_inner_half 10",
		recipe = {
			{modname .. ":stair_" .. subname .. "_half", "", ""},
			{recipeitem, recipeitem, modname .. ":stair_" .. subname .. "_half"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_inner_half 10",
		recipe = {
			{"", "", modname .. ":stair_" .. subname .. "_half"},
			{modname .. ":stair_" .. subname .. "_half", recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_inner_half_raised 7",
		recipe = {
			{modname .. ":stair_" .. subname .. "_half", "", ""},
			{recipeitem, recipeitem, modname .. ":stair_" .. subname .. "_half"},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_inner_half_raised 7",
		recipe = {
			{"", "", modname .. ":stair_" .. subname .. "_half"},
			{modname .. ":stair_" .. subname .. "_half", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
--===================================================== Outer ==

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_outer 7",
		recipe = {
			{modname .. ":micro_" .. subname, "", ""},
			{recipeitem, modname .. ":micro_" .. subname, ""},
			{recipeitem, recipeitem, modname .. ":micro_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_outer 7",
		recipe = {
			{"", "", modname .. ":micro_" .. subname},
			{"", modname .. ":micro_" .. subname, recipeitem},
			{modname .. ":micro_" .. subname, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_outer_half 10",
		recipe = {
			{modname .. ":micro_" .. subname, "", ""},
			{recipeitem, recipeitem, modname .. ":micro_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_outer_half 10",
		recipe = {
			{"", "", modname .. ":micro_" .. subname},
			{modname .. ":micro_" .. subname, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_outer_half_raised 7",
		recipe = {
			{modname .. ":micro_" .. subname, "", ""},
			{recipeitem, recipeitem, modname .. ":micro_" .. subname},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. "_outer_half_raised 7",
		recipe = {
			{"", "", modname .. ":micro_" .. subname},
			{modname .. ":micro_" .. subname, recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
--================================================= Shapeless ==
	
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname, modname .. ":slope_" .. subname},
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe =  {modname .. ":slope_" .. subname .. "_outer_cut", modname .. ":slope_" .. subname .. "_outer_cut"},
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
		output = modname .. ":slab_" .. subname,
		recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half"},
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
		output = modname .. ":slope_" .. subname .. "_outer_cut_half_raised",
		recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_outer_cut_half"},
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_outer_cut",
		recipe =  {modname .. ":slope_" .. subname .. "_outer"},
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_outer_cut_half",
		recipe =  {modname .. ":slope_" .. subname .. "_outer_half"},
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = modname .. ":slope_" .. subname .. "_outer_cut_half_raised",
		recipe =  {modname .. ":slope_" .. subname .. "_outer_half_raised"},
	})
end
