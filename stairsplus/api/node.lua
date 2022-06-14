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

function api.format_name(shape, node)
	local mod, name = node:match("^([^:]+):(.*)$")
	local shape_def = api.registered_shapes[shape]
	return ("%s:%s"):format(mod, shape_def.name_format:format(name))
end

function api.register_single(node, shape, overrides)
	local node_def = table.copy(minetest.registered_nodes[node])
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
		groups = groups,
		use_texture_alpha = node_def.use_texture_alpha,
		paramtype = shape_def.paramtype or "light",
		paramtype2 = shape_def.paramtype2 or "facedir",
		light_source = scale_light(node_def.light_source, shape_def),
	}

	local tiles = node_def.tiles
	if #tiles > 1 and (node_def.drawtype or ""):match("glass") then
		def.tiles = {tiles[1]}
	else
		def.tiles = tiles
	end

	if node_def.short_description then
		def.short_description = S(shape_def.description, node_def.short_description)
	end

	if def.use_texture_alpha == nil then
		def.use_texture_alpha = node_def.use_texture_alpha
	end

	if node_def.drop then
		local item = api.get_shaped_name(node_def.drop, shape)
		if item then
			def.drop = item
		end
	end

	table_set_all(def, overrides or {})

	local shaped_name = api.format_name(shape, node)
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

function api.get_shapes(node)
	return table_sort_keys(api.shapes_by_node[node])
end

function api.get_shapes_hash(node)
	return api.shapes_by_node[node]
end

function api.get_shaped_name(node, shape_or_item)
	local t = ItemStack(shape_or_item):to_table()

	if api.registered_shapes[t.name] then
		t.name = api.format_name(t.name, node)

	elseif t.name == "node" then
		t.name = node
	end

	return ItemStack(t):to_string()
end

minetest.register_on_mods_loaded(function()
	stairsplus.log("info", "registering schema crafts")
	for node in pairs(api.shapes_by_node) do
		api.register_schema_crafts_for_node(node)
	end
end)
