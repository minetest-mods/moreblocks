stairsplus.api.circular_saw = {}
local circular_saw = stairsplus.api.circular_saw
local api = stairsplus.api
local station = api.station

local get_location_string = stairsplus.util.get_location_string

local S = stairsplus.S
local F = minetest.formspec_escape

local formspec_style = stairsplus.resources.formspec_style


function circular_saw.build_formspec(meta, inv)
	local inv_location = get_location_string(inv)
	return ([[
		size[10,11]
		%s
		label[0,0;]
		label[0,0;%s]
		list[%s;stairsplus:input;1.7,0;1,1;]
		label[0,1;%s]
		list[%s;stairsplus:micro;1.7,1;1,1;]
		label[0,2;%s]
		list[%s;stairsplus:recycle;1.7,2;1,1;]
		field[0.3,3.5;1,1;max_offered;%s:;%i]
		button[1,3.2;1.7,1;Set;%s]

		list[%s;stairsplus:output;2.8,0;7,7;]
		list[current_player;main;1.5,7.25;8,4;]

		listring[%s;stairsplus:output]
		listring[current_player;main]
		listring[%s;stairsplus:recycle]

		listring[%s;stairsplus:micro]
		listring[current_player;main]

		listring[%s;stairsplus:input]
		listring[current_player;main]
	]]):format(
		formspec_style,
		F(S("Nodes")),
		inv_location,
		F(S("Microblocks")),
		inv_location,
		F(S("Input")),
		inv_location,
		F(S("Max")),
		meta:get_int("stairsplus:max_offered"),
		F(S("Set")),
		inv_location,
		inv_location,
		inv_location,
		inv_location,
		inv_location
	)
end

function circular_saw.update_metadata(meta, inv)
	local parts = {S("Circular Saw")}

	local owner = meta:get_string("owner")
	if owner ~= "" then
		table.insert(parts, S("(owned by @1)", owner))
	end

	local working_on = station.get_current_node(inv)
	if working_on then
		local stack = ItemStack(working_on)
		table.insert(parts, S("Working on @1", stack:get_short_description() or stack:get_description()))
	else
		table.insert(parts, S("Empty"))
	end

	meta:set_string("infotext", table.concat(parts, " "))
end

api.register_station("stairsplus:circular_saw", {
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

	shape_groups = {"legacy"},
	build_formspec = circular_saw.build_formspec,
	update_metadata = circular_saw.update_metadata,
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
		def.on_construct(pos, {"legacy"}, circular_saw.build_formspec, circular_saw.update_metadata)
	end,
})
