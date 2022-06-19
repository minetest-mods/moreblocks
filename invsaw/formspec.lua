local station = stairsplus.api.station
local circular_saw = stairsplus.api.circular_saw

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
