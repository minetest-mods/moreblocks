-- Default stairs/slabs/panels/microblocks.

local default_nodes = {
	"stone",
	"cobble",
	"mossycobble",
	"brick",
	"sandstone",
	"steelblock",
	"goldblock",
	"copperblock",
	"bronzeblock",
	"diamondblock",
	"desert_stone",
	-- "desert_cobble", Does not work in minetest_game.
	"glass",
	"tree",
	"wood",
	"jungletree",
	"junglewood",
	"obsidian",
	"obsidian_glass",
	"stonebrick",
	"desert_stonebrick",
	"sandstonebrick",
}

for _, name in pairs(default_nodes) do
	local nodename = "default:"..name
	local ndef = minetest.registered_nodes[nodename]
	local groups = {}
	for k, v in pairs(ndef.groups) do groups[k] = v end
	local drop
	if type(ndef.drop) == "string" then
		drop = ndef.drop:sub(9)
	end
	stairsplus:register_all("moreblocks", name, nodename, {
		description = ndef.description,
		drop = drop,
		groups = groups,
		sounds = ndef.sounds,
		tiles = ndef.tiles,
		sunlight_propagates = true,
	})
end

