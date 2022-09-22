stairsplus.util = {
	table_set_all = function(t, other_table)
		for key, value in pairs(other_table) do
			t[key] = value
		end
		return t
	end,

	table_is_empty = function(t)
		return next(t) == nil
	end,

	table_sort_keys = function(t, sort_function)
		local sorted = {}
		for key in pairs(t) do
			table.insert(sorted, key)
		end
		if sort_function then
			table.sort(sorted, sort_function)
		else
			table.sort(sorted)
		end
		return sorted
	end,

	table_equals = function(t1, t2)
		if t1 == t2 then
			return true
		end

		local tt1 = type(t1)
		local tt2 = type(t2)

		if tt1 ~= tt2 then
			return false
		end

		if tt1 ~= "table" or tt2 ~= "table" then
			return t1 == t2
		end

		for k1, v1 in pairs(t1) do
			if v1 ~= t2[k1] then
				return false
			end
		end

		for k2, v2 in pairs(t2) do
			if t1[k2] ~= v2 then
				return false
			end
		end

		return true
	end,

	get_location_string = function(inv)
		local location = inv:get_location()
		if location.type == "node" then
			return ("nodemeta:%i,%i,%i"):format(location.pos.x, location.pos.y, location.pos.z)
		elseif location.type == "player" then
			return ("player:%s"):format(location.name)
		elseif location.type == "detached" then
			return ("detached:%s"):format(location.name)
		else
			error(("unexpected location? %s"):format(dump(location)))
		end
	end,

	resolve_aliases = function(node, seen)
		seen = seen or {}
		if seen[node] then
			error(("alias loop on %s"):format(node))
		end
		local aliased_to = minetest.registered_aliases[node]
		if aliased_to then
			seen[node] = true
			return stairsplus.util.resolve_aliases(aliased_to, seen)
		end
		return node
	end,
}
