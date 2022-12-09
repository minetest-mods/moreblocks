local rotate_and_place = minetest.rotate_and_place

local get_node_vars = stairs.util.get_node_vars
local get_stair_images = stairs.util.get_stair_images

local legacy = {}

local nodeboxes = {
	stair = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
			{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
		},
	},
	slab = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	stair_inner = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
			{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
		},
	},
	stair_outer = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
			{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
		},
	},
}

local function register_generic(name, recipeitem, groups, images, description, sounds, worldaligntex, nodebox)
	if not nodebox then
		error()
	end

	local light_source, texture_alpha, sunlight = get_node_vars(recipeitem)

	local stair_images = get_stair_images(images, worldaligntex)

	minetest.register_node(name, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = texture_alpha,
		sunlight_propagates = sunlight,
		light_source = light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		node_box = nodebox,
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})
end

function legacy.register_stair(subname, recipeitem, groups, images, description, sounds, worldaligntex)
	local new_groups = table.copy(groups)
	new_groups.stair = 1

	register_generic(":stairs:stair_" .. subname, recipeitem, new_groups, images, description, sounds,
		worldaligntex, nodeboxes.stair)

	if recipeitem and minetest.registered_nodes[recipeitem] then
		-- Recipe matches appearence in inventory
		minetest.register_craft({
			output = "stairs:stair_" .. subname .. " 8",
			recipe = {
				{"", "", recipeitem},
				{"", recipeitem, recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use stairs to craft full blocks again (1:1)
		minetest.register_craft({
			output = recipeitem .. " 3",
			recipe = {
				{"stairs:stair_" .. subname, "stairs:stair_" .. subname},
				{"stairs:stair_" .. subname, "stairs:stair_" .. subname},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time

		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "stairs:stair_" .. subname,
				burntime = math.floor(baseburntime * 0.75),
			})
		end
	end
end


-- Register slab
-- Node will be called stairs:slab_<subname>

function legacy.register_slab(subname, recipeitem, groups, images, description, sounds, worldaligntex)
	local new_groups = table.copy(groups)
	new_groups.slab = 1

	register_generic(":stairs:slab_" .. subname, recipeitem, new_groups, images, description, sounds,
		worldaligntex, nodeboxes.slab)

	if recipeitem and minetest.registered_nodes[recipeitem] then
		minetest.register_craft({
			output = "stairs:slab_" .. subname .. " 6",
			recipe = {
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use 2 slabs to craft a full block again (1:1)
		minetest.register_craft({
			output = recipeitem,
			recipe = {
				{"stairs:slab_" .. subname},
				{"stairs:slab_" .. subname},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "stairs:slab_" .. subname,
				burntime = math.floor(baseburntime * 0.5),
			})
		end
	end
end

-- Register inner stair
-- Node will be called stairs:stair_inner_<subname>

function legacy.register_stair_inner(subname, recipeitem, groups, images, description, sounds, worldaligntex,
									 full_description)

	local new_groups = table.copy(groups)
	new_groups.stair = 1
	if full_description then
		description = full_description
	else
		description = "Inner " .. description
	end

	register_generic(":stairs:stair_inner_" .. subname, recipeitem, new_groups, images, description, sounds,
		worldaligntex, nodeboxes.stair_inner)

	if recipeitem and minetest.registered_nodes[recipeitem] then
		minetest.register_craft({
			output = "stairs:stair_inner_" .. subname .. " 7",
			recipe = {
				{"", recipeitem, ""},
				{recipeitem, "", recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time

		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "stairs:stair_inner_" .. subname,
				burntime = math.floor(baseburntime * 0.875),
			})
		end
	end
end


-- Register outer stair
-- Node will be called stairs:stair_outer_<subname>

function legacy.register_stair_outer(subname, recipeitem, groups, images, description, sounds, worldaligntex,
									 full_description)
	local new_groups = table.copy(groups)
	new_groups.stair = 1

	if full_description then
		description = full_description
	else
		description = "Outer " .. description
	end

	register_generic(":stairs:stair_outer_" .. subname, recipeitem, new_groups, images, description, sounds,
		worldaligntex, nodeboxes.stair_outer)

	if recipeitem and minetest.registered_nodes[recipeitem] then
		minetest.register_craft({
			output = "stairs:stair_outer_" .. subname .. " 6",
			recipe = {
				{"", recipeitem, ""},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time

		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = "stairs:stair_outer_" .. subname,
				burntime = math.floor(baseburntime * 0.625),
			})
		end
	end
end

stairs.legacy = legacy
