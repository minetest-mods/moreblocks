-- legacy: register all the expected variants for e.g. default, wool, gloopblocks, etc.
-- provide a configuration option to *disable* legacy. it must be enabled by default, to prevent breaking
-- existing servers
local api = stairsplus.api

function stairsplus:register_all(modname, subname, recipeitem, fields)
	api.register_all(recipeitem, fields)

	local old_name = ("%s:%s"):format(modname, subname)
	if old_name ~= recipeitem then
		api.register_alias_all(old_name, recipeitem)
	end
end

function stairsplus:register_alias_all(modname_old, subname_old, modname_new, subname_new)
	api.register_alias_all(
		("%s:%s"):format(modname_old, subname_old),
		("%s:%s"):format(modname_new, subname_new)
	)
end

function stairsplus:register_alias_force_all(modname_old, subname_old, modname_new, subname_new)
	api.register_alias_force_all(
		("%s:%s"):format(modname_old, subname_old),
		("%s:%s"):format(modname_new, subname_new)
	)
end
