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

function stairsplus_legacy.register_legacy(node, overrides, meta)
	if stairsplus_legacy.settings.stairsplus_legacy_mode then
		stairsplus.api.register_group(node, "legacy", overrides, meta)
	else
		stairsplus.api.register_group(node, "common", overrides, meta)
	end
end

if stairsplus_legacy.has.basic_materials and stairsplus_legacy.settings.basic_materials then
	stairsplus_legacy.dofile("basic_materials")
end

if stairsplus_legacy.has.default and stairsplus_legacy.settings.default then
	stairsplus_legacy.dofile("default")
end

if stairsplus_legacy.has.farming and stairsplus_legacy.settings.farming then
	stairsplus_legacy.dofile("farming")
end

if stairsplus_legacy.has.gloopblocks and stairsplus_legacy.settings.gloopblocks then
	stairsplus_legacy.dofile("gloopblocks")
end

if stairsplus_legacy.has.technic and stairsplus_legacy.settings.technic then
	stairsplus_legacy.dofile("technic")
end

if stairsplus_legacy.has.prefab and stairsplus_legacy.settings.prefab then
	stairsplus_legacy.dofile("prefab")
end

if stairsplus_legacy.has.wool and stairsplus_legacy.settings.wool then
	stairsplus_legacy.dofile("wool")
end
