-- Load translation library if intllib is installed

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
	else
	S = function ( s ) return s end
end

-- Node will be called <modname>panel_<subname>

function register_panel(modname, subname, recipeitem, groups, images, description, drop, light)

	minetest.register_node(":" .. modname .. ":panel_" .. subname, {
		description = S("%s Panel"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":panel_" .. drop,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":panel_" .. subname .. "_1", {
		description = S("%s Panel"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":panel_" .. drop .. "_1",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
		},
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":panel_" .. subname .. "_2", {
		description = S("%s Panel"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":panel_" .. drop .. "_2",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
		},
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":panel_" .. subname .. "_4", {
		description = S("%s Panel"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":panel_" .. drop .. "_4",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, -0.25, 0.5},
		},
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":panel_" .. subname .. "_12", {
		description = S("%s Panel"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":panel_" .. drop .. "_12",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.25, 0.5},
		},
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":panel_" .. subname .. "_14", {
		description = S("%s Panel"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":panel_" .. drop .. "_14",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.375, 0.5},
		},
		on_place = stairsplus_rotate_and_place
	})
	
	minetest.register_node(":" .. modname .. ":panel_" .. subname .. "_15", {
		description = S("%s Panel"):format(S(description)),
		drawtype = "nodebox",
		tiles = images,
		light_source = light,
		drop = modname .. ":panel_" .. drop .. "_15",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.4375, 0.5},
		},
		on_place = stairsplus_rotate_and_place
	})

	minetest.register_alias(modname..":panel_"..subname.."_bottom", modname..":panel_"..subname)
end

