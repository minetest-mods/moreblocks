-- for creating the circular saw and similar nodes

local api = stairsplus.api

local S = stairsplus.S
local F = minetest.formspec_escape

local default_stack_max = tonumber(minetest.settings:get("default_stack_max")) or 99

local station = {}

--[[
TODO this isn't actually modular in the right way for adding different kinds of stations
TODO e.g. some of this stuff is very particular to the saw itself
]]

local function get_cost(shaped_node)
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

local function get_current_node(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	local input_stack = inv:get_stack("input", 1)
	if not input_stack:is_empty() then
		return input_stack:get_name()
	end

	local micro_stack = inv:get_stack("micro", 1)
	if not micro_stack:is_empty() then
		return api.get_node_of_shaped_node(micro_stack:get_name())
	end

	local recycle_stack = inv:get_stack("recycle", 1)
	if not recycle_stack:is_empty() then
		return api.get_node_of_shaped_node(recycle_stack:get_name())
	end
end

function station.update_infotext(pos)
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

-- Player has taken something out of the box or placed something inside
-- that amounts to count microblocks:
function station.update_inventory(pos, taken_stack)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	local node = get_current_node(pos)

	if not node then
		for i = 1, inv:get_size("output") do
			inv:set_stack("output", i, ItemStack())
		end
		return
	end

	local input_stack = inv:get_stack("input", 1)
	local micro_stack = inv:get_stack("micro", 1)
	local recycle_stack = inv:get_stack("recycle", 1)

	local current_value = 8 * input_stack:get_count() + micro_stack:get_count()
	local new_value = current_value + get_cost(recycle_stack:get_name()) * recycle_stack:get_count()
	if taken_stack then
		new_value = new_value - get_cost(taken_stack:get_name()) * taken_stack:get_count()
	end
	local new_micros = new_value % 8
	local new_blocks = math.floor(new_value / 8)

	inv:set_stack("input", 1, ItemStack({name = node, count = new_blocks}))
	inv:set_stack("micro", 1, ItemStack({name = api.get_micronode(node), count = new_micros}))
	inv:set_stack("recycle", 1, ItemStack())

	if new_value == 0 then
		for i = 1, inv:get_size("output") do
			inv:set_stack("output", i, "")
		end
		return
	end

	local valid_shapes = api.shapes_by_node[node]
	local shape_groups = minetest.registered_nodes[minetest.get_node(pos).name]._stairsplus_shape_groups

	local max_offered = meta:get_int("max_offered")

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
				inv:set_stack("output", i, stack)
				i = i + 1
			end
		end
	end

	for j = i, inv:get_size("output") do
		inv:set_stack("output", j, "")
	end
end

-- The amount of items offered per shape can be configured:
function station.on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local max = tonumber(fields.max_offered)
	if max and max > 0 then
		meta:set_int("max_offered", max)
		-- Update to show the correct number of items:
		station.update_inventory(pos)
		station.update_infotext(pos)
	end
end

-- Moving the inventory of the station around is not allowed because it
-- is a fictional inventory. Moving inventory around would be rather
-- impractical and make things more difficult to calculate:
function station.allow_metadata_inventory_move()
	return 0
end

function station.allow_metadata_inventory_put(pos, listname, index, stack, player)
	if listname ~= "recycle" then
		return 0
	end

	local shaped_node = stack:get_name()
	local node = api.get_node_of_shaped_node(shaped_node)
	local shape = api.get_shape_of_shaped_node(shaped_node)

	if not (node and shape) then
		return 0
	end

	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local current_node = get_current_node(pos)

	if current_node and node ~= current_node then
		return 0
	end

	local count = stack:get_count()
	local cost = get_cost(shaped_node)

	local input_stack = inv:get_stack("input", 1)
	local micro_stack = inv:get_stack("micro", 1)

	local current_value = 8 * input_stack:get_count() + micro_stack:get_count()
	local max_value = 8 * ItemStack(node):get_stack_max() + 7

	local available_value = max_value - current_value
	local available_count = math.floor(available_value / cost)

	return math.min(count, available_count)
end

function station.on_metadata_inventory_put(pos, listname, index, stack, player)
	station.update_inventory(pos)
	station.update_infotext(pos)
end

function station.on_metadata_inventory_take(pos, listname, index, stack, player)
	if listname == "output" then
		station.update_inventory(pos, stack)
	else
		station.update_inventory(pos)
	end

	station.update_infotext(pos)
end

function station.build_formspec()
	local fancy_inv = ""
	if stairsplus.has.default then
		-- prepend background and slot styles from default if available
		fancy_inv = default.gui_bg .. default.gui_bg_img .. default.gui_slots
	end

	return ([[
		size[11,10]
		%s
		label[0,0;%s]
		list[current_name;input;1.7,0;1,1;]
		label[0,1;%s]
		list[current_name;micro;1.7,1;1,1;]
		label[0,2;%s]
		list[current_name;recycle;1.7,2;1,1;]
		field[0.3,3.5;1,1;max_offered;%s:;${max_offered}]
		button[1,3.2;1.7,1;Set;%s]

		list[current_name;output;2.8,0;8,6;]
		list[current_player;main;1.5,6.25;8,4;]

		listring[current_name;output]
		listring[current_player;main]
		listring[current_name;recycle]

		listring[current_name;micro]
		listring[current_player;main]

		listring[current_name;input]
		listring[current_player;main]
	]]):format(
		fancy_inv, S("Nodes"), F(S("Microblocks")), F(S("Input")), F(S("Max")), F(S("Set"))
	)
end

function station.on_construct(pos)
	local meta = minetest.get_meta(pos)

	meta:set_string("formspec", station.build_formspec())
	meta:set_string("max_offered", default_stack_max) -- How many items of this kind are offered by default?

	local inv = meta:get_inventory()

	inv:set_size("input", 1)    -- Input slot for full blocks of material x.
	inv:set_size("micro", 1)    -- Storage for 1-7 surplus microblocks.
	inv:set_size("recycle", 1)  -- Surplus partial blocks can be placed here.
	inv:set_size("output", 6 * 8) -- 6x8 versions of stair-parts of material x.

	station.update_infotext(pos)
end

function station.after_place_node(pos, placer)
	local meta = minetest.get_meta(pos)
	if minetest.is_player(placer) then
		meta:set_string("owner", placer:get_player_name())
	end
end

function station.can_dig(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	return inv:is_empty("input") and inv:is_empty("micro")
end

function api.register_station(name, shape_groups, def)
	def.after_place_node = def.after_place_node or station.after_place_node
	def.on_construct = def.on_construct or station.on_construct
	def.can_dig = def.can_dig or station.can_dig
	def.on_receive_fields = def.on_receive_fields or station.on_receive_fields
	def.allow_metadata_inventory_move = def.allow_metadata_inventory_move or station.allow_metadata_inventory_move
	def.allow_metadata_inventory_put = def.allow_metadata_inventory_put or station.allow_metadata_inventory_put
	def.allow_metadata_inventory_take = def.allow_metadata_inventory_take or station.allow_metadata_inventory_take
	def.on_metadata_inventory_put = def.on_metadata_inventory_put or station.on_metadata_inventory_put
	def.on_metadata_inventory_take = def.on_metadata_inventory_take or station.on_metadata_inventory_take
	def._stairsplus_shape_groups = shape_groups

	minetest.register_node(name, def)
end

api.station = station
