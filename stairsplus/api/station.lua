-- for creating the circular saw and similar nodes

local api = stairsplus.api

local has_metadata = stairsplus.util.has_metadata
local resolve_aliases = stairsplus.util.resolve_aliases

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
		return api.get_node_of_shaped_node(input_stack:get_name())
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

function station.on_receive_fields(meta, inv, formname, fields, sender, build_formspec, update_metadata)
	local max = tonumber(fields.max_offered)
	if max and max > 0 then
		meta:set_int("stairsplus:max_offered", max)
		-- Update to show the correct number of items:
		station.update_inventory(meta, inv)
		if update_metadata then
			update_metadata(meta, inv)
		end

		if build_formspec then
			meta:set_string("formspec", build_formspec(meta, inv))
		end
	end

	return not not fields.max_offered
end

local function fix_aliases(inv)
	local input = inv:get_stack("stairsplus:input", 1)
	input:set_name(resolve_aliases(input:get_name()))
	inv:set_stack("stairsplus:input", 1, input)

	local micro = inv:get_stack("stairsplus:micro", 1)
	micro:set_name(resolve_aliases(micro:get_name()))
	inv:set_stack("stairsplus:micro", 1, micro)

	local recycle = inv:get_stack("stairsplus:recycle", 1)
	recycle:set_name(resolve_aliases(recycle:get_name()))
	inv:set_stack("stairsplus:recycle", 1, recycle)

	for i = 1, inv:get_size("stairsplus:output") do
		local output = inv:get_stack("stairsplus:output", i)
		output:set_name(resolve_aliases(output:get_name()))
		inv:set_stack("stairsplus:output", i, output)
	end
end

function station.update_inventory(meta, inv, taken_stack)
	fix_aliases(inv)

	local node = station.get_current_node(inv)
	local valid_shapes = api.shapes_by_node[node]

	if not (node and valid_shapes) then
		inv:set_stack("stairsplus:input", 1, ItemStack())
		inv:set_stack("stairsplus:micro", 1, ItemStack())
		inv:set_stack("stairsplus:recycle", 1, ItemStack())
		for i = 1, inv:get_size("stairsplus:output") do
			inv:set_stack("stairsplus:output", i, ItemStack())
		end
		return
	end

	local input_stack = inv:get_stack("stairsplus:input", 1)
	local micro_stack = inv:get_stack("stairsplus:micro", 1)
	local recycle_stack = inv:get_stack("stairsplus:recycle", 1)

	local input_cost = station.get_cost(input_stack:get_name())
	local micro_cost = station.get_cost(micro_stack:get_name())
	local recycle_cost = station.get_cost(recycle_stack:get_name())

	local total_value = (
		(input_stack:get_count() * input_cost) +
		(micro_stack:get_count() * micro_cost) +
		(recycle_stack:get_count() * recycle_cost)
	)

	if taken_stack then
		total_value = total_value - station.get_cost(taken_stack:get_name()) * taken_stack:get_count()
	end

	local new_micros = total_value % 8
	local new_blocks = math.floor(total_value / 8)

	local micronode = api.get_micronode(node)

	inv:set_stack("stairsplus:input", 1, ItemStack({name = node, count = new_blocks}))
	inv:set_stack("stairsplus:micro", 1, ItemStack({name = micronode, count = new_micros}))
	inv:set_stack("stairsplus:recycle", 1, ItemStack())

	if total_value == 0 then
		for i = 1, inv:get_size("stairsplus:output") do
			inv:set_stack("stairsplus:output", i, "")
		end
		return
	end

	local max_offered = meta:get_int("stairsplus:max_offered")
	local shape_groups = minetest.parse_json(meta:get_string("stairsplus:shape_groups"))

	local i = 1
	for _, group in ipairs(shape_groups) do
		for _, shape in ipairs(api.shapes_by_group[group]) do
			if valid_shapes[shape] then
				local shape_def = api.registered_shapes[shape]
				local shaped_node = api.format_name(node, shape)
				local stack_max = math.min(max_offered, ItemStack(shaped_node):get_stack_max())
				local count = math.min(stack_max, math.floor(total_value / shape_def.eighths))
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

-- Moving the inventory of the station around is not allowed because it
-- is a fictional inventory. Moving inventory around would be rather
-- impractical and make things more difficult to calculate:
function station.allow_inventory_move(meta, inv, from_list, from_index, to_list, to_index, count, player)
	return 0
end

function station.allow_inventory_put(meta, inv, listname, index, stack, player)
	if listname == "stairsplus:output" then
		return 0
	end

	if has_metadata(stack) then
		return 0
	end

	local to_put_node = resolve_aliases(stack:get_name())
	local node = api.get_node_of_shaped_node(to_put_node)
	local shape = api.get_shape_of_shaped_node(to_put_node)

	if not (node and shape) then
		return 0
	end

	local current_node = station.get_current_node(inv)

	local input_stack = inv:get_stack("stairsplus:input", 1)
	local micro_stack = inv:get_stack("stairsplus:micro", 1)

	if current_node and node ~= current_node then
		if (
			(input_stack:is_empty() and listname == "stairsplus:micro") or
			(micro_stack:is_empty() and listname == "stairsplus:input")
		) then
			return stack:get_count()
		else
			return 0
		end
	end

	local count = stack:get_count()
	local cost = station.get_cost(to_put_node)

	local current_value = 8 * input_stack:get_count() + micro_stack:get_count()
	local max_value = 8 * ItemStack(node):get_stack_max() + 7

	local available_value = max_value - current_value
	local available_count = math.floor(available_value / cost)

	return math.min(count, available_count)
end

function station.on_inventory_put(meta, inv, listname, index, stack, player, update_metadata)
	station.update_inventory(meta, inv)
	if update_metadata then
		update_metadata(meta, inv)
	end
end

function station.on_inventory_take(meta, inv, listname, index, stack, player, update_metadata)
	if listname == "stairsplus:output" then
		station.update_inventory(meta, inv, stack)
	else
		station.update_inventory(meta, inv)
	end

	if update_metadata then
		update_metadata(meta, inv)
	end
end

function station.initialize_metadata(meta, inv, shape_groups, build_formspec, update_metadata)
	meta:set_string("stairsplus:shape_groups", minetest.write_json(shape_groups))

	if meta:get_int("max_offered") ~= 0 then
		meta:set_int("stairsplus:max_offered", meta:get_int("max_offered"))

	elseif meta:get_int("stairsplus:max_offered") == 0 then
		meta:set_int("stairsplus:max_offered", default_stack_max)
	end

	if build_formspec then
		meta:set_string("formspec", build_formspec(meta, inv))
	end

	if update_metadata then
		update_metadata(meta, inv)
	end
end

function station.initialize_inventory(inv, shape_groups)
	local output_size = 0
	for _, group in ipairs(shape_groups) do
		output_size = output_size + #api.shapes_by_group[group]
	end

	inv:set_size("stairsplus:input", 1)
	inv:set_size("stairsplus:micro", 1)
	inv:set_size("stairsplus:recycle", 1)
	inv:set_size("stairsplus:output", output_size)

	-- get rid of old lists
	for _, listname in ipairs({"input", "micro", "recycle", "output"}) do
		if inv:get_size(listname) > 0 then
			inv:set_list(("stairsplus:%s"):format(listname), inv:get_list(listname))
			inv:set_size(listname, 0)
		end
	end
end

function station.on_construct(pos, shape_groups, build_formspec, update_metadata)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	station.initialize_inventory(inv, shape_groups)
	station.initialize_metadata(meta, inv, shape_groups, build_formspec, update_metadata)
	station.update_inventory(meta, inv)
end

function station.after_place_node(pos, placer)
	local meta = minetest.get_meta(pos)
	if minetest.is_player(placer) then
		meta:set_string("owner", placer:get_player_name())
	end
end

function api.register_station(name, def)
	local shape_groups = def.shape_groups
	local build_formspec = def.build_formspec
	local update_metadata = def.update_metadata

	if not shape_groups then
		error("station requires shape_groups defined")
	end

	def.shape_groups = nil
	def.build_formspec = nil
	def.update_metadata = nil

	def.after_place_node = def.after_place_node or station.after_place_node
	def.on_construct = def.on_construct or
		function(pos)
			return station.on_construct(pos, shape_groups, build_formspec, update_metadata)
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
				meta, inv, formname, fields, sender, build_formspec, update_metadata
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
			return station.on_inventory_put(meta, inv, listname, index, stack, player, update_metadata)
		end

	def.on_metadata_inventory_take = def.on_metadata_inventory_take or
		function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return station.on_inventory_take(meta, inv, listname, index, stack, player, update_metadata)
		end

	def._stairsplus_shape_groups = shape_groups

	def.groups = table.copy(def.groups or {})
	def.groups.stairsplus_station = 1

	minetest.register_node(name, def)
end

api.station = station
