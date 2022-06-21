local api = stairsplus.api

local table_is_empty = stairsplus.util.table_is_empty

function api.register_alias_shape(old_node, new_node, shape)
	local old_shaped_node = api.format_name(old_node, shape)
	local new_shaped_node = api.format_name(new_node, shape)

	minetest.register_alias(old_shaped_node, new_shaped_node)

	local shape_def = api.registered_shapes[shape]
	if shape_def.aliases then
		local old_mod, old_name = old_node:match("^([^:]+):(.*)$")
		for _, alias in ipairs(shape_def.aliases) do
			old_shaped_node = ("%s:%s"):format(old_mod, alias:format(old_name))
			minetest.register_alias(old_shaped_node, new_shaped_node)
		end
	end
end

function api.register_alias_all(old_node, new_node)
	for shape in pairs(api.registered_shapes) do
		api.register_alias_shape(old_node, new_node, shape)
	end
end

function api.register_alias_shapes(old_node, new_node, shapes)
	for _, shape in ipairs(shapes) do
		api.register_alias_shape(old_node, new_node, shape)
	end
end

function api.register_alias_group(old_node, new_node, group)
	for _, shape in ipairs(api.shapes_by_group[group] or {}) do
		api.register_alias_shape(old_node, new_node, shape)
	end
end

function api.register_alias_groups(old_node, new_node, groups)
	for _, group in ipairs(groups) do
		api.register_alias_group(old_node, new_node, group)
	end
end

function api.register_alias_force_shape(old_node, new_node, shape)
	local old_shaped_node = api.format_name(old_node, shape)
	local new_shaped_node = api.format_name(new_node, shape)

	minetest.register_alias_force(old_shaped_node, new_shaped_node)

	local shape_def = api.registered_shapes[shape]
	if shape_def.aliases then
		local old_mod, old_name = old_node:match("^([^:]+):(.*)$")
		for _, alias in ipairs(shape_def.aliases) do
			old_shaped_node = ("%s:%s"):format(old_mod, alias:format(old_name))
			minetest.register_alias_force(old_shaped_node, new_shaped_node)
		end
	end

	local nodes = api.nodes_by_shape[shape] or {}
	if nodes[old_node] then
		nodes[old_node] = nil
		nodes[new_node] = true
		api.nodes_by_shape[shape] = nodes
	end

	local old_shapes = api.shapes_by_node[old_node] or {}
	if old_shapes[shape] then
		old_shapes[shape] = nil
		if table_is_empty(old_shapes) then
			api.shapes_by_node[old_node] = nil
		else
			api.shapes_by_node[old_node] = old_shapes
		end

		local new_shapes = api.shapes_by_node[new_node] or {}
		new_shapes[new_node] = true
		api.shapes_by_node[new_node] = new_shapes
	end
end

function api.register_alias_force_all(old_node, new_node)
	for shape in pairs(api.registered_shapes) do
		api.register_alias_force_shape(old_node, new_node, shape)
	end
end

function api.register_alias_force_shapes(old_node, new_node, shapes)
	for _, shape in ipairs(shapes) do
		api.register_alias_force_shape(old_node, new_node, shape)
	end
end

function api.register_alias_force_group(old_node, new_node, group)
	for _, shape in ipairs(api.shapes_by_group[group] or {}) do
		api.register_alias_force_shape(old_node, new_node, shape)
	end
end

function api.register_alias_force_groups(old_node, new_node, groups)
	for _, group in ipairs(groups) do
		api.register_alias_force_group(old_node, new_node, group)
	end
end
