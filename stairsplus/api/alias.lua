local api = stairsplus.api

local table_is_empty = stairsplus.util.table_is_empty

function api.register_alias_single(old_node, new_node, shape)
	local old_shaped_node = api.format_name(shape, old_node)
	local new_shaped_node = api.format_name(shape, new_node)

	minetest.register_alias(old_shaped_node, new_shaped_node)
end

function api.register_alias_all(old_node, new_node)
	for shape in pairs(api.registered_shapes) do
		api.register_alias_single(old_node, new_node, shape)
	end
end

function api.register_alias_force_single(old_node, new_node, shape)
	local old_shaped_node = api.format_name(shape, old_node)
	local new_shaped_node = api.format_name(shape, new_node)

	minetest.register_alias_force(old_shaped_node, new_shaped_node)

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
		api.register_alias_force_single(old_node, new_node, shape)
	end
end
