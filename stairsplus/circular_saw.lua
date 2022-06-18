local api = stairsplus.api
local station = api.station

local S = stairsplus.S
local F = minetest.formspec_escape

local formspec_style = stairsplus.resources.formspec_style

local function update_infotext(pos)
	local meta = minetest.get_meta(pos)

	local parts = {}
	if station.can_dig(pos) then
		table.insert(parts, S("Circular Saw is empty"))
	end

	local owner = meta:get_string("owner")
	if owner ~= "" then
		table.insert(parts, S("(owned by @1)", meta:get_string("owner")))
	end

	meta:set_string("infotext", table.concat(parts, " "))
end

local function build_formspec()
	return ([[
		size[12,10]
		%s
		label[0,0;%s]
		list[current_name;input;1.7,0;1,1;]
		label[0,1;%s]
		list[current_name;micro;1.7,1;1,1;]
		label[0,2;%s]
		list[current_name;recycle;1.7,2;1,1;]
		field[0.3,3.5;1,1;max_offered;%s:;${max_offered}]
		button[1,3.2;1.7,1;Set;%s]

		list[current_name;output;2.8,0;9,6;]
		list[current_player;main;1.5,6.25;8,4;]

		listring[current_name;output]
		listring[current_player;main]
		listring[current_name;recycle]

		listring[current_name;micro]
		listring[current_player;main]

		listring[current_name;input]
		listring[current_player;main]
	]]):format(
		formspec_style, S("Nodes"), F(S("Microblocks")), F(S("Input")), F(S("Max")), F(S("Set"))
	)
end

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

	build_formspec = build_formspec,
	update_infotext = update_infotext,
})

local cm = stairsplus.resources.craft_materials

if stairsplus.settings.circular_saw_crafting and cm.steel_ingot then
	minetest.register_craft({
		output = "stairsplus:circular_saw",
		recipe = {
			{"", cm.steel_ingot, ""},
			{"group:wood", "group:wood", "group:wood"},
			{"group:wood", "", "group:wood"},
		}
	})
end

minetest.register_lbm({
	label = "Upgrade legacy saws",
	name = "stairsplus:replace_legacy_saws",
	nodenames = {"stairsplus:circular_saw"},
	run_at_every_load = false,
	action = function(pos, node)
		local def = minetest.registered_nodes[node.name]
		def.on_construct(pos)
	end,
})
