local api = stairsplus.api

local in_creative_inventory = stairsplus.settings.in_creative_inventory

api.passthrough_groups = {}
api.scale_groups = {}
api.ignore_groups = {}

function api.register_passthrough_group(group)
	api.passthrough_groups[group] = true
end

function api.register_passthrough_groups(groups)
	for _, group in ipairs(groups) do
		api.register_passthrough_group(group)
	end
end

function api.register_scale_group(group)
	api.scale_groups[group] = true
end

function api.register_scale_groups(groups)
	for _, group in ipairs(groups) do
		api.register_scale_group(group)
	end
end

function api.register_ignore_group(group)
	api.ignore_groups[group] = true
end

function api.register_ignore_groups(groups)
	for _, group in ipairs(groups) do
		api.register_ignore_group(group)
	end
end

function api.build_groups(node, shape)
	local node_def = minetest.registered_nodes[node]

	local groups = {
		[("shape_%s"):format(shape)] = 1,
		not_in_creative_inventory = in_creative_inventory and 1 or nil,
	}

	local shape_def = api.registered_shapes[shape]

	for group, value in pairs(node_def.groups) do
		if api.passthrough_groups[group] then
			groups[group] = value

		elseif api.scale_groups[group] then
			groups[group] = (shape_def.eighths / 8) * value

		elseif not api.ignore_groups[group] then
			groups[shape_def.name_format:format(group)] = value
		end
	end

	return groups
end
