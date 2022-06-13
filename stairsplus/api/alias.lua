
local api = stairsplus.api

function api.register_alias_all(old_node, new_node)
	local old_mod, old_name = old_node:match("^([^:]+:(.*)$")
	local new_mod, new_name = new_node:match("^([^:]+:(.*)$")
	for _, shape_def in pairs(stairsplus.api.registered_shapes) do
		minetest.register_alias(
			("%s:%s"):format(old_mod, shape_def.name_format:format(old_name)),
			("%s:%s"):format(new_mod, shape_def.name_format:format(new_name))
		)
	end
end

function api.register_alias_force_all(old_node, new_node)
	local old_mod, old_name = old_node:match("^([^:]+:(.*)$")
	local new_mod, new_name = new_node:match("^([^:]+:(.*)$")
	for _, shape_def in pairs(stairsplus.api.registered_shapes) do
		minetest.register_alias_force(
			("%s:%s"):format(old_mod, shape_def.name_format:format(old_name)),
			("%s:%s"):format(new_mod, shape_def.name_format:format(new_name))
		)
	end
end
