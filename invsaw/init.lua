local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

invsaw = {
	version = {3, 0, 0},
	fork = "minetest_mods",

	modname = modname,
	modpath = modpath,

	S = S,

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

invsaw.users = {}

invsaw.dofile("settings")
invsaw.dofile("privs")
invsaw.dofile("api")
invsaw.dofile("inventory")
invsaw.dofile("formspec")
invsaw.dofile("unified_inventory")
