stairsplus.util = {
	table_set_all = function(t, other_table)
		for key, value in pairs(other_table) do
			t[key] = value
		end
		return t
	end,

	table_is_empty = function(t)
		return not next(t)
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
			if not v1 == t2[k1] then
				return false
			end
		end

		for k2, v2 in pairs(t2) do
			if not t1[k2] == v2 then
				return false
			end
		end

		return true
	end,

	check_call = function(func)
		-- wrap a function w/ logic to avoid crashing the game
		local f = function(...)
			local status, out = pcall(func, ...)
			if status then
				return out
			else
				local message = ("Error (func): %s %s"):format(out, dump({...}))
				stairsplus.log("error", message)
				error(message)
			end
		end
		return f
	end
}
