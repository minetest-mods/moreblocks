-- for creating the circular saw and similar nodes

local api = stairsplus.api

function api.register_station(name, shape_groups, def)
	minetest.register_node(name, def)
end



local F = minetest.formspec_escape

local circular_saw = {}


-- The amount of items offered per shape can be configured:
function circular_saw.on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local max = tonumber(fields.max_offered)
	if max and max > 0 then
		meta:set_string("max_offered", max)
		-- Update to show the correct number of items:
		circular_saw:update_inventory(pos, 0)
	end
end


-- Moving the inventory of the circular_saw around is not allowed because it
-- is a fictional inventory. Moving inventory around would be rather
-- impractical and make things more difficult to calculate:
function circular_saw.allow_metadata_inventory_move(
	pos, from_list, from_index, to_list, to_index, count, player)
	return 0
end


-- Only input- and recycle-slot are intended as input slots:
function circular_saw.allow_metadata_inventory_put(
	pos, listname, index, stack, player)
	-- The player is not allowed to put something in there:
	if listname == "output" or listname == "micro" then
		return 0
	end

	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stackname = stack:get_name()
	local count = stack:get_count()

	-- Only allow those items that are offered in the output inventory to be recycled:
	if listname == "recycle" then
		if not inv:contains_item("output", stackname) then
			return 0
		end
		local stackmax = stack:get_stack_max()
		local instack = inv:get_stack("input", 1)
		local microstack = inv:get_stack("micro", 1)
		local incount = instack:get_count()
		local incost = (incount * 8) + microstack:get_count()
		local maxcost = (stackmax * 8) + 7
		local cost = circular_saw:get_cost(inv, stackname)
		if (incost + cost) > maxcost then
			return math.max((maxcost - incost) / cost, 0)
		end
		return count
	end

	-- Only accept certain blocks as input which are known to be craftable into stairs:
	if listname == "input" then
		if not inv:is_empty("input") then
			if inv:get_stack("input", index):get_name() ~= stackname then
				return 0
			end
		end
		if not inv:is_empty("micro") then
			local microstackname = inv:get_stack("micro", 1):get_name():gsub("^.+:micro_", "", 1)
			local cutstackname = stackname:gsub("^.+:", "", 1)
			if microstackname ~= cutstackname then
				return 0
			end
		end
		for name, t in pairs(circular_saw.known_nodes) do
			if name == stackname and inv:room_for_item("input", stack) then
				return count
			end
		end
		return 0
	end
end

-- Taking is allowed from all slots (even the internal microblock slot).
-- Putting something in is slightly more complicated than taking anything
-- because we have to make sure it is of a suitable material:
function circular_saw.on_metadata_inventory_put(
	pos, listname, index, stack, player)
	-- We need to find out if the circular_saw is already set to a
	-- specific material or not:
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stackname = stack:get_name()
	local count = stack:get_count()

	-- Putting something into the input slot is only possible if that had
	-- been empty before or did contain something of the same material:
	if listname == "input" then
		-- Each new block is worth 8 microblocks:
		circular_saw:update_inventory(pos, 8 * count)
	elseif listname == "recycle" then
		-- Lets look which shape this represents:
		local cost = circular_saw:get_cost(inv, stackname)
		local input_stack = inv:get_stack("input", 1)
		-- check if this would not exceed input itemstack max_stacks
		if input_stack:get_count() + ((cost * count) / 8) <= input_stack:get_stack_max() then
			circular_saw:update_inventory(pos, cost * count)
		end
	end
end

function circular_saw.allow_metadata_inventory_take(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local input_stack = inv:get_stack(listname, index)
	local player_inv = player:get_inventory()
	if not player_inv:room_for_item("main", input_stack) then
		return 0
	else
		return stack:get_count()
	end
end

function circular_saw.on_metadata_inventory_take(
	pos, listname, index, stack, player)

	-- Prevent (inbuilt) swapping between inventories with different blocks
	-- corrupting player inventory or Saw with 'unknown' items.
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local input_stack = inv:get_stack(listname, index)
	if not input_stack:is_empty() and input_stack:get_name() ~= stack:get_name() then
		local player_inv = player:get_inventory()

		-- Prevent arbitrary item duplication.
		inv:remove_item(listname, input_stack)

		if player_inv:room_for_item("main", input_stack) then
			player_inv:add_item("main", input_stack)
		end

		circular_saw:reset(pos)
		return
	end

	-- If it is one of the offered stairs: find out how many
	-- microblocks have to be subtracted:
	if listname == "output" then
		-- We do know how much each block at each position costs:
		local cost = circular_saw.cost_in_microblocks[index]
			* stack:get_count()

		circular_saw:update_inventory(pos, -cost)
	elseif listname == "micro" then
		-- Each microblock costs 1 microblock:
		circular_saw:update_inventory(pos, -stack:get_count())
	elseif listname == "input" then
		-- Each normal (= full) block taken costs 8 microblocks:
		circular_saw:update_inventory(pos, 8 * -stack:get_count())
	end
	-- The recycle field plays no role here since it is processed immediately.
end

function circular_saw.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local fancy_inv = ""
	if has_default_mod then
		-- prepend background and slot styles from default if available
		fancy_inv = default.gui_bg .. default.gui_bg_img .. default.gui_slots
	end
	meta:set_string(
	--FIXME Not work with @n in this part bug in minetest/minetest#7450.
		"formspec", "size[11,10]" .. fancy_inv ..
			"label[0,0;" .. S("Input material") .. "]" ..
			"list[current_name;input;1.7,0;1,1;]" ..
			"label[0,1;" .. F(S("Left-over")) .. "]" ..
			"list[current_name;micro;1.7,1;1,1;]" ..
			"label[0,2;" .. F(S("Recycle output")) .. "]" ..
			"list[current_name;recycle;1.7,2;1,1;]" ..
			"field[0.3,3.5;1,1;max_offered;" .. F(S("Max")) .. ":;${max_offered}]" ..
			"button[1,3.2;1.7,1;Set;" .. F(S("Set")) .. "]" ..
			"list[current_name;output;2.8,0;8,6;]" ..
			"list[current_player;main;1.5,6.25;8,4;]" ..
			"listring[current_name;output]" ..
			"listring[current_player;main]" ..
			"listring[current_name;input]" ..
			"listring[current_player;main]" ..
			"listring[current_name;micro]" ..
			"listring[current_player;main]" ..
			"listring[current_name;recycle]" ..
			"listring[current_player;main]"
	)

	meta:set_int("anz", 0) -- No microblocks inside yet.
	meta:set_string("max_offered", 99) -- How many items of this kind are offered by default?
	meta:set_string("infotext", S("Circular Saw is empty"))

	local inv = meta:get_inventory()
	inv:set_size("input", 1)    -- Input slot for full blocks of material x.
	inv:set_size("micro", 1)    -- Storage for 1-7 surplus microblocks.
	inv:set_size("recycle", 1)  -- Surplus partial blocks can be placed here.
	inv:set_size("output", 6 * 8) -- 6x8 versions of stair-parts of material x.

	circular_saw:reset(pos)
end

function circular_saw.can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if not inv:is_empty("input") or
		not inv:is_empty("micro") or
		not inv:is_empty("recycle") then
		return false
	end
	-- Can be dug by anyone when empty, not only by the owner:
	return true
end
