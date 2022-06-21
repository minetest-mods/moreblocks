local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

stairsplus_legacy = {
	version = {3, 0, 0},
	fork = "minetest_mods",

	modname = modname,
	modpath = modpath,

	S = S,

	has = {
		basic_materials = minetest.get_modpath("basic_materials"),
		default = minetest.get_modpath("default"),
		farming = minetest.get_modpath("farming"),
		gloopblocks = minetest.get_modpath("gloopblocks"),
		prefab = minetest.get_modpath("prefab"),
		stairs = minetest.get_modpath("stairs"),
		technic = minetest.get_modpath("technic"),
		wool = minetest.get_modpath("wool"),
	},

	log = function(level, messagefmt, ...)
		return minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
	end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

stairsplus_legacy.dofile("settings")
stairsplus_legacy.dofile("resources")

function stairsplus_legacy.register_legacy(node, overrides, meta)
	if stairsplus.settings.legacy_mode then
		stairsplus.api.register_group(node, "legacy", overrides, meta)
	else
		stairsplus.api.register_group(node, "common", overrides, meta)
	end
end

for mod, enabled in pairs(stairsplus_legacy.settings) do
	if enabled then
		stairsplus_legacy.dofile(mod)
	end
end
