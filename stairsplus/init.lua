local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

stairsplus = {
	version = {3, 0, 0},
	fork = "minetest_mods",

	modname = modname,
	modpath = modpath,

	S = S,

	has = {
		default = minetest.get_modpath("default"),
		i3 = minetest.get_modpath("i3"),
		stairs = minetest.get_modpath("stairs"),
		unified_inventory = minetest.get_modpath("unified_inventory"),
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

-- please don't change the order in which things are loaded, without understanding why they're ordered like this
stairsplus.dofile("settings")
stairsplus.dofile("util")

stairsplus.dofile("api", "init")

stairsplus.dofile("compat1", "init")

stairsplus.dofile("shapes", "init")
stairsplus.dofile("groups", "init")
stairsplus.dofile("craft_schemas", "init")

stairsplus.dofile("resources", "init")
stairsplus.dofile("circular_saw")

stairsplus.dofile("compat2", "init")
