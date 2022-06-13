-- for registering variants of a specific node
--[[

]]
local api = stairsplus.api

local legacy_mode = stairsplus.settings.legacy_mode
local in_creative_inventory = stairsplus.settings.in_creative_inventory

local S = stairsplus.S

local function scale_light(light_source, shape_def)
	if not light_source or light_source == 0 then
		return 0
	elseif legacy_mode then
		return light_source - 1
	end

	return math.max(1, math.min(math.round(light_source * shape_def.eighths / 4), light_source))
end

function api.register_single(node, shape, overrides)
	local mod, name = node:match("^([^:]+):(.*)$")
	local node_def = table.copy(minetest.registered_nodes[node])
	local shape_def = api.registered_shapes[shape]

	local groups = {
		[shape] = 1,
		not_in_creative_inventory = in_creative_inventory,
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

	for k, v in pairs(overrides or {}) do
		def[k] = v
	end

	minetest.register_node((":%s:%s"):format(mod, shape_def.name_format:format(name)), def)

	if shape_def.aliases then
		for _, alias in ipairs(shape_def.aliases) do
			minetest.register_alias(
				("%s:%s"):format(mod, alias:format(name)),
				("%s:%s"):format(mod, shape_def.name_format:format(name))
			)
		end
	end
end

function api.register_all(node, overrides)
	for shape in pairs(api.registered_shapes) do
		api.register_single(node, shape, overrides)
	end
	api.register_schema_crafts_for_node(node)
end

function api.register_custom(node, list, overrides)
	for _, shape in ipairs(list) do
		api.register_single(node, shape, overrides)
	end
	api.register_schema_crafts_for_node(node)
end

function api.register_group(node, group, overrides)
	for _, shape in ipairs(api.shapes_by_group[group] or {}) do
		api.register_single(node, shape, overrides)
	end
	api.register_schema_crafts_for_node(node)
end
