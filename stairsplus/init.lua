--[[
More Blocks: Stairs+

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Nodes will be called <modname>:{stair,slab,panel,micro,slope}_<subname>
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
		basic_materials = minetest.get_modpath("basic_materials"),
		default = minetest.get_modpath("default"),
		gloopblocks = minetest.get_modpath("gloopblocks"),
		stairs = minetest.get_modpath("stairs"),
		technic = minetest.get_modpath("technic"),
		prefab = minetest.get_modpath("prefab"),
		wool = minetest.get_modpath("wool"),
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

stairsplus.dofile("settings")
stairsplus.dofile("util")
stairsplus.dofile("resources", "init")
stairsplus.dofile("api", "init")
stairsplus.dofile("shapes", "init")
stairsplus.dofile("craft_schemas")
stairsplus.dofile("circular_saw")
stairsplus.dofile("compat", "init")
