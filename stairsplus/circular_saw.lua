--[[
More Blocks: circular saw

Copyright © 2011-2020 Hugo Locurcio, Sokomine and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]
local api = stairsplus.api
local S = stairsplus.S
local cm = stairsplus.resources.craft_materials

api.register_station("stairsplus:circular_saw", {"legacy"}, {
	description = S("Circular Saw"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.4, -0.25, 0.25, -0.25}, -- Leg
			{0.25, -0.5, 0.25, 0.4, 0.25, 0.4}, -- Leg
			{-0.4, -0.5, 0.25, -0.25, 0.25, 0.4}, -- Leg
			{0.25, -0.5, -0.4, 0.4, 0.25, -0.25}, -- Leg
			{-0.5, 0.25, -0.5, 0.5, 0.375, 0.5}, -- Tabletop
			{-0.01, 0.4375, -0.125, 0.01, 0.5, 0.125}, -- Saw blade (top)
			{-0.01, 0.375, -0.1875, 0.01, 0.4375, 0.1875}, -- Saw blade (bottom)
			{-0.25, -0.0625, -0.25, 0.25, 0.25, 0.25}, -- Motor case
		},
	},
	tiles = {
		"stairsplus_circular_saw_top.png",
		"stairsplus_circular_saw_bottom.png",
		"stairsplus_circular_saw_side.png"
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	sounds = stairsplus.resources.sounds.wood,
})

if cm.steel_ingot then
	if stairsplus.settings.circular_saw_crafting then
		minetest.register_craft({
			output = "stairsplus:circular_saw",
			recipe = {
				{"", cm.steel_ingot, ""},
				{"group:wood", "group:wood", "group:wood"},
				{"group:wood", "", "group:wood"},
			}
		})
	end
end
