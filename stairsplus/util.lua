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
	end
}
