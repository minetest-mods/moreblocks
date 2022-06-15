local api = stairsplus.api

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
