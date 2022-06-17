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
