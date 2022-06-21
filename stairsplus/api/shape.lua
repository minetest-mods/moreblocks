local api = stairsplus.api

api.registered_shapes = {}
api.shapes_by_group = {}

function api.register_shape(name, def)
	stairsplus.log("info", "registering shape %q", name)
	def.shape_groups = def.shape_groups or {}
	api.registered_shapes[name] = def

	for group in pairs(def.shape_groups) do
		local shapes = api.shapes_by_group[group] or {}
		table.insert(shapes, name)
		api.shapes_by_group[group] = shapes
	end
end

function api.register_shape_group(shape_group, shapes)
	for _, shape in ipairs(shapes) do
		api.registered_shapes[shape].shape_groups[shape_group] = 1
	end
	api.shapes_by_group[shape_group] = shapes
end
