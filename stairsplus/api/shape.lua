-- register shapes (e.g. 1/16 slab, 1/8 slab, 1/4 slab, etc)
--[[
stairsplus.api.register_shape("micro_1", {
	name_format = "micro_%s_1",
	description = "@1 1/16 Microblock",
	shape_groups = {micro = 1},
	eighths = 1,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0, -0.4375, 0.5},
	},
})
]]
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
