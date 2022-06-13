-- register shapes (e.g. 1/16 slab, 1/8 slab, 1/4 slab, etc)

stairsplus.api.registered_shapes = {}
stairsplus.api.shapes_by_group = {}

function stairsplus.api.register_shape(name , def)
	stairsplus.api.registered_shapes[name] = def

	for group in pairs(def.shape_groups or {}) do
		local shapes = stairsplus.api.shapes_by_group[group] or {}
		table.insert(shapes, name)
		stairsplus.api.shapes_by_group[group] = shapes
	end
end
