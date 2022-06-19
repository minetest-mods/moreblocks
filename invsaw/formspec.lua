local ui = unified_inventory
local get_location_string = stairsplus.util.get_location_string
local station = stairsplus.api.station
local circular_saw = stairsplus.api.circular_saw

local S = stairsplus.S
local F = minetest.formspec_escape

invsaw.formspec = [[
	formspec_version[4]
	size[16,15]
	background9[0,0;1,1;ui_formbg_9_sliced.png;true;16]
	listcolors[#00000000;#FFFFFF80;#00000000]
	label[0.75,1.3;%s]
	%s
	list[%s;stairsplus:input;3,1;1,1;]
	label[0.75,3;%s]
	%s
	list[%s;stairsplus:micro;3,2.5;1,1;]
	label[0.75,4.3;%s]
	%s
	list[%s;stairsplus:recycle;3,4;1,1;]
	field[0.75,6;1,1;max_offered;%s:;%i]
	button[2,6;1,1;Set;%s]
	%s
	list[%s;stairsplus:output;5,1;8,6;]
	%s
	%s
	list[current_player;main;4,9.5;8,4;]
]]

function invsaw.build_formspec(meta, inv)
	local inv_location = get_location_string(inv)
	return invsaw.formspec:format(
		F(S("Nodes")),
		ui.single_slot(1.88, 0.88, true),
		inv_location,
		F(S("Microblocks")),
		ui.single_slot(1.88, 2.38),
		inv_location,
		F(S("Input")),
		ui.single_slot(1.88, 3.88),
		inv_location,
		F(S("Max")),
		meta:get_int("stairsplus:max_offered"),
		F(S("Set")),
		ui.make_inv_img_grid(3.88, 0.88, 8, 6),
		inv_location,
		ui.make_inv_img_grid(3.88, 9.38, 8, 1, true),
		ui.make_inv_img_grid(3.88, 10.63, 8, 3)
	)
end

function invsaw.show_formspec(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local inv = player:get_inventory()

	minetest.show_formspec(name, "invsaw", circular_saw.build_formspec(meta, inv))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local meta = player:get_meta()
	local inv = player:get_inventory()

	if fields.saw then
		if invsaw.allow_use_saw(player) then
			invsaw.show_formspec(player)
		end

		return true

	elseif station.on_receive_fields(meta, inv, formname, fields, player) then
		if invsaw.allow_use_saw(player) then
			invsaw.show_formspec(player)
		end

		return true
	end
end)
