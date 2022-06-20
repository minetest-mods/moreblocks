-- for creating the circular saw and similar nodes

local api = stairsplus.api

local default_stack_max = tonumber(minetest.settings:get("default_stack_max")) or 99

local station = {}

function station.get_cost(shaped_node)
	if shaped_node == "" then
		return 0
	end

	local shape = api.get_shape_of_shaped_node(shaped_node)
	if shape == "node" then
		return 8
	end

	local shape_def = api.registered_shapes[shape]
	return shape_def and shape_def.eighths
end

function station.get_current_node(inv)
	local input_stack = inv:get_stack("stairsplus:input", 1)
	if not input_stack:is_empty() then
		return input_stack:get_name()
	end

	local micro_stack = inv:get_stack("stairsplus:micro", 1)
	if not micro_stack:is_empty() then
		return api.get_node_of_shaped_node(micro_stack:get_name())
	end

	local recycle_stack = inv:get_stack("stairsplus:recycle", 1)
	if not recycle_stack:is_empty() then
		return api.get_node_of_shaped_node(recycle_stack:get_name())
	end
end

function station.can_dig(meta, inv)
	return inv:is_empty("stairsplus:input") and inv:is_empty("stairsplus:micro")
end

function station.on_receive_fields(meta, inv, formname, fields, sender, build_formspec, update_infotext)
	local max = tonumber(fields.max_offered)
	if max and max > 0 then
		meta:set_int("stairsplus:max_offered", max)
		-- Update to show the correct number of items:
		station.update_inventory(meta, inv)
		if update_infotext then
			update_infotext(meta, inv)
		end

		if build_formspec then
			meta:set_string("formspec", build_formspec(meta, inv))
		end
	end

	return not not fields.max_offered
end

function station.update_inventory(meta, inv, taken_stack)
	local node = station.get_current_node(inv)

	if not node then
		for i = 1, inv:get_size("stairsplus:output") do
			inv:set_stack("stairsplus:output", i, ItemStack())
		end
		return
	end

	local input_stack = inv:get_stack("stairsplus:input", 1)
	local micro_stack = inv:get_stack("stairsplus:micro", 1)
	local recycle_stack = inv:get_stack("stairsplus:recycle", 1)

	local current_value = 8 * input_stack:get_count() + micro_stack:get_count()
	local new_value = current_value + station.get_cost(recycle_stack:get_name()) * recycle_stack:get_count()
	if taken_stack then
		new_value = new_value - station.get_cost(taken_stack:get_name()) * taken_stack:get_count()
	end
	local new_micros = new_value % 8
	local new_blocks = math.floor(new_value / 8)

	inv:set_stack("stairsplus:input", 1, ItemStack({name = node, count = new_blocks}))
	inv:set_stack("stairsplus:micro", 1, ItemStack({name = api.get_micronode(node), count = new_micros}))
	inv:set_stack("stairsplus:recycle", 1, ItemStack())

	if new_value == 0 then
		for i = 1, inv:get_size("stairsplus:output") do
			inv:set_stack("stairsplus:output", i, "")
		end
		return
	end

	local valid_shapes = api.shapes_by_node[node]
	local max_offered = meta:get_int("stairsplus:max_offered")
	local shape_groups = minetest.parse_json(meta:get_string("stairsplus:shape_groups"))

	local i = 1
	for _, group in ipairs(shape_groups) do
		for _, shape in ipairs(api.shapes_by_group[group]) do
			if valid_shapes[shape] then
				local shape_def = api.registered_shapes[shape]
				local shaped_node = api.format_name(node, shape)
				local stack_max = math.min(max_offered, ItemStack(shaped_node):get_stack_max())
				local count = math.min(stack_max, math.floor(new_value / shape_def.eighths))
				local stack
				if count > 0 then
					stack = ItemStack({name = shaped_node, count = count})
				else
					stack = ""
				end
				inv:set_stack("stairsplus:output", i, stack)
				i = i + 1
			end
		end
	end

	for j = i, inv:get_size("stairsplus:output") do
		inv:set_stack("stairsplus:output", j, "")
	end
end

function station.on_inventory_put(meta, inv, listname, index, stack, player, update_infotext)
	station.update_inventory(meta, inv)
	if update_infotext then
		update_infotext(meta, inv)
	end
end

function station.on_inventory_take(meta, inv, listname, index, stack, player, update_infotext)
	if listname == "stairsplus:output" then
		station.update_inventory(meta, inv, stack)
	else
		station.update_inventory(meta, inv)
	end

	if update_infotext then
		update_infotext(meta, inv)
	end
end

-- Moving the inventory of the station around is not allowed because it
-- is a fictional inventory. Moving inventory around would be rather
-- impractical and make things more difficult to calculate:
function station.allow_inventory_move()
	return 0
end

function station.allow_inventory_put(meta, inv, listname, index, stack, player)
	if listname ~= "stairsplus:recycle" then
		return 0
	end

	local shaped_node = stack:get_name()
	local node = api.get_node_of_shaped_node(shaped_node)
	local shape = api.get_shape_of_shaped_node(shaped_node)

	if not (node and shape) then
		return 0
	end

	local current_node = station.get_current_node(inv)

	if current_node and node ~= current_node then
		return 0
	end

	local count = stack:get_count()
	local cost = station.get_cost(shaped_node)

	local input_stack = inv:get_stack("stairsplus:input", 1)
	local micro_stack = inv:get_stack("stairsplus:micro", 1)

	local current_value = 8 * input_stack:get_count() + micro_stack:get_count()
	local max_value = 8 * ItemStack(node):get_stack_max() + 7

	local available_value = max_value - current_value
	local available_count = math.floor(available_value / cost)

	return math.min(count, available_count)
end

function station.initialize_metadata(meta, inv, shape_groups, build_formspec, update_infotext)
	meta:set_string("stairsplus:shape_groups", minetest.write_json(shape_groups))
	if meta:get_int("stairsplus:max_offered") == 0 then
		meta:set_int("stairsplus:max_offered", default_stack_max)
	end

	if build_formspec then
		meta:set_string("formspec", build_formspec(meta, inv))
	end

	if update_infotext then
		update_infotext(meta, inv)
	end
end

function station.initialize_inventory(inv)
	inv:set_size("stairsplus:input", 1)
	inv:set_size("stairsplus:micro", 1)
	inv:set_size("stairsplus:recycle", 1)
	inv:set_size("stairsplus:output", 7 * 7)

	-- get rid of old lists
	for _, listname in ipairs({"input", "micro", "recycle", "output"}) do
		if inv:get_size(listname) > 0 then
			inv:set_list(("stairsplus:%s"):format(listname), inv:get_list(listname))
			inv:set_size(listname, 0)
		end
	end
end

function station.on_construct(pos, shape_groups, build_formspec, update_infotext)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	station.initialize_inventory(inv)
	station.initialize_metadata(meta, inv, shape_groups, build_formspec, update_infotext)
end

function station.after_place_node(pos, placer)
	local meta = minetest.get_meta(pos)
	if minetest.is_player(placer) then
		meta:set_string("owner", placer:get_player_name())
	end
end

function api.register_station(name, shape_groups, def)
	def.after_place_node = def.after_place_node or station.after_place_node
	def.on_construct = def.on_construct or
		function(pos)
			return station.on_construct(pos, shape_groups, def.build_formspec, def.update_infotext)
		end

	def.can_dig = def.can_dig or
		function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return station.can_dig(meta, inv, player)
		end

	def.on_receive_fields = def.on_receive_fields or
		function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return station.on_receive_fields(
				meta, inv, formname, fields, sender, def.build_formspec, def.update_infotext
			)
		end

	def.allow_metadata_inventory_move = def.allow_metadata_inventory_move or
		function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return station.allow_inventory_move(meta, inv, from_list, from_index, to_list, to_index, count, player)
		end

	def.allow_metadata_inventory_put = def.allow_metadata_inventory_put or
		function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return station.allow_inventory_put(meta, inv, listname, index, stack, player)
		end

	def.on_metadata_inventory_put = def.on_metadata_inventory_put or
		function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return station.on_inventory_put(meta, inv, listname, index, stack, player, def.update_infotext)
		end

	def.on_metadata_inventory_take = def.on_metadata_inventory_take or
		function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return station.on_inventory_take(meta, inv, listname, index, stack, player, def.update_infotext)
		end

	def._stairsplus_shape_groups = shape_groups

	def.groups = table.copy(def.groups or {})
	def.groups.stairsplus_station = 1

	minetest.register_node(name, def)
end

api.station = station
