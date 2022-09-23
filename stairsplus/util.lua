local util = {}

function util.table_set_all(t, other_table)
	for key, value in pairs(other_table) do
		t[key] = value
	end
	return t
end

function util.table_is_empty(t)
	return next(t) == nil
end

function util.table_sort_keys(t, sort_function)
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
end

function util.table_equals(t1, t2)
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
end

function util.get_location_string(inv)
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
end

function util.resolve_aliases(node, seen)
	seen = seen or {}
	if seen[node] then
		error(("alias loop on %s"):format(node))
	end
	local aliased_to = minetest.registered_aliases[node]
	if aliased_to then
		seen[node] = true
		return util.resolve_aliases(aliased_to, seen)
	end
	return node
end

function util.has_metadata(item)
	item = type(item) == "userdata" and item or ItemStack(item)
	local meta = item:get_meta()

	return not util.table_is_empty(meta:to_table().fields)
end

stairsplus.util = util
