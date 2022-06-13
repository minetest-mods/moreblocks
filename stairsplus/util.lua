stairsplus.util = {
	table_set_all = function(t, other_table)
		for key, value in pairs(other_table) do
			t[key] = value
		end
		return t
	end
}
