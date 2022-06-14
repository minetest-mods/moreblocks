-- for registering variants of a specific node
--[[

]]
local api = stairsplus.api

local table_set_all = stairsplus.util.table_set_all
local table_sort_keys = stairsplus.util.table_sort_keys

local S = stairsplus.S

local legacy_mode = stairsplus.settings.legacy_mode
local in_creative_inventory = stairsplus.settings.in_creative_inventory

api.nodes_by_shape = {}
api.shapes_by_node = {}

local function scale_light(light_source, shape_def)
	if not light_source or light_source == 0 then
		return 0
	elseif legacy_mode then
		return light_source - 1
	end

	return math.max(1, math.min(math.round(light_source * shape_def.eighths / 4), light_source))
end

function api.format_name(node, shape)
	local mod, name = node:match("^([^:]+):(.*)$")
	local shape_def = api.registered_shapes[shape]
	return ("%s:%s"):format(mod, shape_def.name_format:format(name))
end

local function check_node_validity(node_def)
	if node_def.type ~= "node" then
		error(("cannot register non-node %q w/ stairsplus"):format(node))
	end

	if (
		node_def.drawtype == "airlike" or
		node_def.drawtype == "liquid" or
		node_def.drawtype == "flowingliquid" or
		node_def.drawtype == "torchlike" or
		node_def.drawtype == "signlike" or
		node_def.drawtype == "plantlike" or
		node_def.drawtype == "firelike" or
		node_def.drawtype == "fencelike" or
		node_def.drawtype == "raillike" or
		node_def.drawtype == "nodebox" or
		node_def.drawtype == "mesh" or
		node_def.drawtype == "plantlike_rooted"
	) then
		error(("cannot register %q w/ drawtype %q w/ stairsplus"):format(node, node_def.drawtype))
	end

	if (
		node_def.paramtype2 == "flowingliquid" or
		node_def.paramtype2 == "wallmounted" or
		node_def.paramtype2 == "leveled" or
		node_def.paramtype2 == "degrotate" or
		node_def.paramtype2 == "meshoptions" or
		node_def.paramtype2 == "color" or
		node_def.paramtype2 == "colorfacedir" or
		node_def.paramtype2 == "colorwallmounted" or
		node_def.paramtype2 == "glasslikeliquidlevel" or
		node_def.paramtype2 == "colordegrotate"
	) then
		error(("cannot register %q w/ paramtype2 %q w/ stairsplus"):format(node, node_def.paramtype2))
	end
end

function api.register_single(node, shape, overrides)
	local node_def = table.copy(minetest.registered_nodes[node])
	check_node_validity(node_def)

	if shape ~= "micro_8" and not (api.nodes_by_shape.micro_8 or {})[node] then
		-- always make sure a microblock exists
		api.register_single(node, "micro_8", overrides)
	end

	if (api.nodes_by_shape[shape] or {})[node] then
		return -- already registered
	end

	local shape_def = api.registered_shapes[shape]

	local groups = {
		[shape] = 1,
		not_in_creative_inventory = in_creative_inventory and 1 or 0,
	}

	for group, value in pairs(node_def.groups) do
		groups[shape_def.name_format:format(group)] = value
	end

	local def = {
		description = S(shape_def.description, node_def.description or node),

		drawtype = shape_def.drawtype,
		mesh = shape_def.mesh,
		node_box = shape_def.node_box,
		collision_box = shape_def.collision_box,
		selection_box = shape_def.selection_box,
		paramtype = shape_def.paramtype or "light",
		paramtype2 = shape_def.paramtype2 or "facedir",

		light_source = scale_light(node_def.light_source, shape_def),
		tiles = node_def.tiles,
		overlay_tiles = node_def.overlay_tiles,
		use_texture_alpha = node_def.use_texture_alpha,
		color = node_def.color,
		stack_max = node_def.stack_max,
		sound = node_def.sound,
		is_ground_content = node_def.is_ground_content,
		walkable = node_def.walkable,
		pointable = node_def.pointable,
		diggable = node_def.diggable,
		climbable = node_def.climbable,
		move_resistance = node_def.move_resistance,
		groups = groups,
	}

	if (node_def.drawtype or ""):match("glass") then
		if #def.tiles > 1 then
			def.tiles = {def.tiles[1]}
		end

		if def.overlay_tiles and #def.overlay_tiles > 1 then
			def.overlay_tiles = {def.overlay_tiles[1]}
		end
	end

	if node_def.short_description then
		def.short_description = S(shape_def.description, node_def.short_description)
	end

	if node_def.drop then
		local item = api.get_shaped_node(node_def.drop, shape)
		if item then
			def.drop = item
		end
	end

	table_set_all(def, overrides or {})

	local shaped_name = api.format_name(node, shape)
	minetest.register_node(":" .. shaped_name, def)

	if shape_def.aliases then
		local mod, name = node:match("^([^:]+):(.*)$")
		for _, alias in ipairs(shape_def.aliases) do
			minetest.register_alias(
				("%s:%s"):format(mod, alias:format(name)),
				shaped_name
			)
		end
	end

	local nodes = api.nodes_by_shape[shape] or {}
	nodes[node] = true
	api.nodes_by_shape[shape] = nodes

	local shapes = api.shapes_by_node[node] or {}
	shapes[shape] = true
	api.shapes_by_node[node] = shapes
end

function api.register_all(node, overrides)
	for shape in pairs(api.registered_shapes) do
		api.register_single(node, shape, overrides)
	end
end

function api.register_custom(node, list, overrides)
	for _, shape in ipairs(list) do
		api.register_single(node, shape, overrides)
	end
end

function api.register_group(node, group, overrides)
	for _, shape in ipairs(api.shapes_by_group[group] or {}) do
		api.register_single(node, shape, overrides)
	end
end

function api.register_groups(node, groups, overrides)
	for _, group in ipairs(groups) do
		api.register_group(node, group, overrides)
	end
end

function api.get_shapes(node)
	return table_sort_keys(api.shapes_by_node[node])
end

function api.get_shapes_hash(node)
	return api.shapes_by_node[node]
end

function api.get_shaped_node(node, shape_or_item)
	local t = ItemStack(shape_or_item):to_table()

	if api.registered_shapes[t.name] then
		t.name = api.format_name(node, t.name)

	elseif t.name == "node" then
		t.name = node
	end

	return ItemStack(t):to_string()
end

function api.get_micronode(node)
	return api.format_name(node, "micro_8")
end

api.node_by_shaped_node = {}
api.shape_by_shaped_node = {}

function api.get_node_of_shaped_node(shaped_node)
	return api.node_by_shaped_node[shaped_node]
end

function api.get_shape_of_shaped_node(shaped_node)
	return api.shape_by_shaped_node[shaped_node]
end

minetest.register_on_mods_loaded(function()
	stairsplus.log("info", "registering schema crafts")
	for node, shapes in pairs(api.shapes_by_node) do
		api.register_schema_crafts_for_node(node)

		for shape in pairs(shapes) do
			local shaped_node = api.format_name(node, shape)
			api.node_by_shaped_node[shaped_node] = node
			api.shape_by_shaped_node[shaped_node] = shape
		end

		api.node_by_shaped_node[node] = node
		api.shape_by_shaped_node[node] = "node"
	end
end)
