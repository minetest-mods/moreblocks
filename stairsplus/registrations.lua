--[[
More Blocks: registrations

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local default_nodes = { -- Default stairs/slabs/panels/microblocks:
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
	"desert_cobble",
	"glass",
	"tree",
	"wood",
	"jungletree",
	"junglewood",
	"pinetree",
	"pinewood",
	"obsidian",
	"obsidian_glass",
	"stonebrick",
	"desert_stonebrick",
	"sandstonebrick",
}

for _, name in pairs(default_nodes) do
	local nodename = "default:" .. name
	local ndef = minetest.registered_nodes[nodename]
	local groups = {}
	for k, v in pairs(ndef.groups)
		-- Ignore wood and stone groups to not make them usable in crafting:
		do if k ~= "wood" and k ~= "stone" then
			groups[k] = v
		end
	end
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

