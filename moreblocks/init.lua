local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

moreblocks = {
	version = {3, 0, 0},
	fork = "minetest_mods",

	modname = modname,
	modpath = modpath,

	S = S,

	has = {
		bucket = minetest.get_modpath("bucket"),
		default = minetest.get_modpath("default"),
		rhotator = minetest.get_modpath("rhotator"),
		screwdriver = minetest.get_modpath("screwdriver"),
		stairs = minetest.get_modpath("stairs"),
		stairsplus = minetest.get_modpath("stairsplus"),
		vessels = minetest.get_modpath("vessels"),
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

moreblocks.dofile("settings")
moreblocks.dofile("util")
moreblocks.dofile("resources", "init")
moreblocks.dofile("api", "init")

moreblocks.dofile("items")
moreblocks.dofile("nodes")
moreblocks.dofile("crafting")
moreblocks.dofile("aliases")
