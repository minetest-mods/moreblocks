local station = stairsplus.api.station

function invsaw.initialize_inventory(player)
	local meta = player:get_meta()
	local inv = player:get_inventory()

	station.initialize_metadata(meta, inv, {"legacy"})
	station.initialize_inventory(inv)
end

function invsaw.drop_inventory(player)
	local pos = player:get_pos()
	local inv = player:get_inventory()
	for _, listname in ipairs({"stairsplus:input", "stairsplus:micro", "stairsplus:recycle"}) do
		for i = 1, inv:get_size(listname) do
			local item = inv:get_stack(listname, i)
			if not item:is_empty() then
				minetest.add_item(pos, item)
			end
		end
		inv:set_size(listname, 0)
	end
	inv:set_size("stairsplus:output", 0)
end

local function is_stairsplus_inventory(listname)
	return (
		listname == "stairsplus:input" or
		listname == "stairsplus:micro" or
		listname == "stairsplus:recycle" or
		listname == "stairsplus:output"
	)
end

minetest.register_allow_player_inventory_action(function(player, action, inv, info)
	local meta = player:get_meta()
	if action == "move" and is_stairsplus_inventory(info.from_list) and is_stairsplus_inventory(info.to_list) then
		return station.allow_inventory_move(
			meta, inv, info.from_list, info.from_index, info.to_list, info.to_index, info.count, player
		)

	elseif action == "move" and is_stairsplus_inventory(info.to_list) then
		local stack = inv:get_stack(info.from_list, info.from_index)
		return station.allow_inventory_put(
			meta, inv, info.to_list, info.to_index, stack, player
		)

	elseif action == "put" and is_stairsplus_inventory(info.listname) then
		return station.allow_inventory_put(
			meta, inv, info.listname, info.index, info.stack, player
		)
	end
end)

minetest.register_on_player_inventory_action(function(player, action, inv, info)
	local meta = player:get_meta()
	if action == "move" and is_stairsplus_inventory(info.from_list) and not is_stairsplus_inventory(info.to_list) then
		local stack = inv:get_stack(info.to_list, info.to_index)
		stack:set_count(info.count)
		station.on_inventory_take(
			meta, inv, info.from_list, info.from_index, stack, player
		)

	elseif action == "move" and not is_stairsplus_inventory(info.from_list) and is_stairsplus_inventory(info.to_list) then
		local stack = inv:get_stack(info.from_list, info.from_index)
		station.on_inventory_put(
			meta, inv, info.to_list, info.to_index, stack, player
		)

	elseif action == "put" and is_stairsplus_inventory(info.listname) then
		station.on_inventory_put(
			meta, inv, info.listname, info.index, info.stack, player
		)

	elseif action == "take" and is_stairsplus_inventory(info.listname) then
		station.on_inventory_take(
			meta, inv, info.listname, info.index, info.stack, player
		)
	end
end)
