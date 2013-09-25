-- Load translation library if intllib is installed

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
	else
	S = function ( s ) return s end
end

circular_saw = {};

circular_saw.known_stairs = {}


-- Register known moreblocks stairs
for i,v in ipairs({"default:wood", "default:stone", "default:cobble", "default:mossycobble", "default:brick", "default:sandstone",
				"default:steelblock", "default:desert_stone", "default:glass", "default:tree", "default:jungletree", "default:stonebrick",
				"default:obsidian", "default:obsidian_glass", "default:stone_bricks", "default:junglewood", "default:goldblock",
				"default:copperblock", "default:bronzeblock", "default:diamondblock", "default:desert_stonebrick", "default:sandstonebrick",

				"moreblocks:coal_stone", "moreblocks:iron_stone", "moreblocks:coal_checker", "moreblocks:iron_checker",
				"moreblocks:cactus_checker", "moreblocks:coal_glass", "moreblocks:iron_glass", "moreblocks:glow_glass",
				"moreblocks:super_glow_glass", "moreblocks:wooden_tile", "moreblocks:stone_tile", "moreblocks:split_stone_tile",
				"moreblocks:iron_stone_bricks", "moreblocks:circle_stone_bricks", "moreblocks:wood_tile_centered", 
				"moreblocks:wood_tile_full", "moreblocks:plank_stone"}) do
	table.insert(circular_saw.known_stairs, v);
end

	
-- How many microblocks does this shape at the output inventory cost?
circular_saw.cost_in_microblocks = { 6, 7, 5, 3, 2, 4, 6,
								 2, 1, 4, 0, 0, 0, 0,
								 0, 0, 0, 0, 0, 0, 0,
								 0, 0, 0, 0, 0, 0, 0 };

-- anz: amount of input material in microblocks
circular_saw.get_stair_output_inv = function(modname, material, anz, max)

	local max_offered = 99;

	if(not(max) or (max == nil) or tonumber(max) > 99 or tonumber(max) < 1) then
		max_offered = 99;
	else
		max_offered = tonumber(max);
	end
	

	-- If there is nothing inside display empty inventory
	if(anz < 1) then
		return { "",  "",  "",  "",  "",  "",  "", 
				"",  "",  "",  "",  "",  "",  "", 
				"",  "",  "",  "",  "",  "",  "", 
				"",  "",  "",  "",  "",  "",  ""};
	end

	return { 
	modname .. ":stair_" .. material .. " "                        .. math.min(math.floor(anz/6), max_offered),
	modname .. ":stair_" .. material .. "_inner "                  .. math.min(math.floor(anz/7), max_offered),
	modname .. ":stair_" .. material .. "_outer "                  .. math.min(math.floor(anz/5), max_offered),
	modname .. ":stair_" .. material .. "_half "                   .. math.min(math.floor(anz/3), max_offered),
	modname .. ":slab_"  .. material .. "_quarter "                .. math.min(math.floor(anz/2), max_offered),
	modname .. ":slab_"  .. material .. " "                        .. math.min(math.floor(anz/4), max_offered),
	modname .. ":slab_"  .. material .. "_three_quarter "          .. math.min(math.floor(anz/6), max_offered),
	
	modname .. ":panel_" .. material .. "_bottom "                 .. math.min(math.floor(anz/2), max_offered),
	modname .. ":micro_" .. material .. "_bottom "                 .. math.min(math.floor(anz/1), max_offered),
	modname .. ":stair_" .. material .. "_alt "                    .. math.min(math.floor(anz/4), max_offered),
	"", 
	}
end


-- Reset empty circular_saw after last full block has been taken out (or the circular_saw has been placed the first tiem); note: max_offered is not reset
circular_saw.reset_circular_saw = function(pos)
	local meta = minetest.env:get_meta(pos);
	local inv  = meta:get_inventory();

	inv:set_list("input",  { "" });
	inv:set_list("micro",  { "" });
	inv:set_list("output",  circular_saw.get_stair_output_inv("",  "",  0, meta:get_string("max_offered")));
	meta:set_int("anz",  0);

	meta:set_string("infotext",  "Circular saw, empty (owned by " .. (meta:get_string("owner") or "") .. ")");
end


-- Player has taken something out of the box or placed something inside; that amounts to count microblocks
circular_saw.update_inventory = function(pos, amount)
	local meta = minetest.env:get_meta(pos);
	local inv  = meta:get_inventory();
	local akt  = meta:get_int("anz");

	-- The material is receicled automaticly
	inv:set_list("recycle",  { "" });

	if(akt + amount < 1) then -- If the last block is taken out

		circular_saw.reset_circular_saw(pos);
		return;

	end
 
	local stack = inv:get_stack("input",  1);
	-- At least one "normal" block is necessary to see what kind of stairs are requested
	if(stack:is_empty()) then

		-- Any microblocks not taken out yet are now lost (covers material loss in the machine)
		circular_saw.reset_circular_saw(pos);
		return;

	end
	local node_name = stack:get_name();
	local liste = node_name:split(":");
	local modname  = liste[1];
	local material = liste[2];
	
	-- Display as many full blocks as possible
	inv:set_list("input",   { modname.. ":" .. material .. " " .. math.floor(   (akt + amount) / 8) });

	-- The stairnodes made of default nodes use moreblocks namespace, other mods keep own.
	if(modname == "default") then modname = "moreblocks"; end
	--print("circular_saw set to " ..modname.. " : " ..material.. " with " .. (akt+amount) .. " microblocks.");

	-- 0-7 microblocks may remain as a rest
	inv:set_list("micro",   { modname.. ":micro_" .. material .. "_bottom " .. ((akt + amount) % 8) });
	-- Display 
	inv:set_list("output",  circular_saw.get_stair_output_inv(modname, material,  (akt + amount), meta:get_string("max_offered")));
	-- Store how many microblocks are available
	meta:set_int("anz",  (akt+amount));

	meta:set_string("infotext",  "Circular saw, working with " ..material.. " (owned by " .. (meta:get_string("owner") or "") .. ")");
end


-- The amount of items offered per shape can be configured
circular_saw.on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.env:get_meta(pos);
	if tonumber(fields.max_offered) and tonumber(fields.max_offered) > 0 and tonumber(fields.max_offered) < 99 then
		meta:set_string("max_offered",  fields.max_offered);
		circular_saw.update_inventory(pos, 0); -- update to show the correct number of items
	end
end


-- Moving the inventory of the circular_saw around is not allowed because it is a fictional inventory
circular_saw.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	-- Moving inventory around would be rather immpractical and make things more difficult to calculate
	return 0;
end


-- Only input- and recycle-slot are intended as input slots
circular_saw.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
 
	-- The player is not allowed to put something in there
	if(listname == "output" or listname == "micro") then
		return 0;
	end

	local meta = minetest.env:get_meta(pos);
	local inv  = meta:get_inventory();
			
	-- Only alow those items that are offered in the output inventory to be recycled
	if(listname == "recycle" and not(inv:contains_item("output",  stack:get_name()))) then
		return 0;
	end

	-- Only accept certain blocks as input which are known to be craftable into stairs
	if(listname == "input") then
	 
		for i,v in ipairs(circular_saw.known_stairs) do

		if(circular_saw.known_stairs[ i ] == stack:get_name()) then
			return stack:get_count();
		end

		end
		return 0;
		
	end
 
	return stack:get_count()
end

-- Taking is allowed from all slots (even the internal microblock slot)

-- Putting something in is slightly more complicated than taking anything because we have to make sure it is of a suitable material
circular_saw.on_metadata_inventory_put = function(pos, listname, index, stack, player)

	-- We need to find out if the circular_saw is already set to a specific material or not
	local meta = minetest.env:get_meta(pos);
	local inv  = meta:get_inventory();

	-- Putting something into the input slot is only possible if that had been empty before or did contain something of the same material
	if(    listname=="input") then

		if( not( inv:is_empty("input"))) then

			local old_stack = inv:get_stack("input", 1 );
			if( old_stack:get_name() ~= stack:get_name() ) then
				return 0;
			end
		end

		-- Each new block is worth 8 microblocks
		circular_saw.update_inventory(pos, 8 * stack:get_count());
		
	elseif(listname=="recycle") then
 
		-- Lets look which shape this represents
		for i,v in ipairs(inv:get_list("output")) do
				
		 if(v:get_name() == stack:get_name()) then
		
			local value = circular_saw.cost_in_microblocks[ i ] * stack:get_count();
			--print("\nRecycling " .. (v:get_name()) .. " into " ..value.. " microblocks.");

			-- We get value microblocks back
			circular_saw.update_inventory(pos, value);
		 end
		end
	end
end

-- The player takes something
circular_saw.on_metadata_inventory_take = function(pos, listname, index, stack, player)
			
	-- If it is one of the offered stairs: find out how many microblocks have to be substracted
	if(listname=="output") then

		-- We do know how much each block at each position costs
		local cost = circular_saw.cost_in_microblocks[ index ] * stack:get_count();

		circular_saw.update_inventory(pos, -1 * cost);

	elseif(listname=="mikro") then

		-- Each microblock costs 1 microblock
		circular_saw.update_inventory(pos, -1 * 1 * stack:get_count());

	elseif(listname=="input") then
	
		-- Each normal (= full) block taken costs 8 microblocks
		circular_saw.update_inventory(pos, -1 * 8 * stack:get_count());

	end
	-- The recycle field plays no role here since it is processed immediately
end


circular_saw.on_construct_init = function(pos, formspec)

	local meta = minetest.env:get_meta(pos)
	meta:set_string("formspec",  formspec); 

	meta:set_int(   "anz",          0); -- No microblocks inside yet
	meta:set_string("max_offered",  99); -- How many items of this kind are offered by default?
	meta:set_string("infotext",     "Circular saw, empty")

	local inv = meta:get_inventory()
	inv:set_size("input",      1)  -- Input slot for full blocks of material x
	inv:set_size("micro",      1)  -- Storage for 1-7 surplus microblocks
	inv:set_size("recycle",    1)  -- Surplus partial blocks can be placed here
	inv:set_size("output",    28) -- 4*7 versions of stair-parts of material x

	circular_saw.reset_circular_saw(pos);
end


circular_saw.can_dig = function(pos,player)
	local meta = minetest.env:get_meta(pos);
	local inv = meta:get_inventory()
	if not inv:is_empty("input") then
		return false
	elseif not inv:is_empty("micro") then
		return false
	elseif not inv:is_empty("recycle") then
		return false
	end

	-- Can be digged by anyone when empty (not only by the owner)
	return true
end,


minetest.register_node("moreblocks:circular_saw",  {
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
		selection_box = {
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
		tiles = {"moreblocks_circular_saw_top.png",  "moreblocks_circular_saw_bottom.png",  "moreblocks_circular_saw_side.png"},
		paramtype = "light", 
		sunlight_propagates = true,
		paramtype2 = "facedir", 
		groups = {cracky=2},
		on_construct = function(pos)
			return circular_saw.on_construct_init(pos,
					 "size[10,9]" ..
					 "list[current_name;input;0,0;1,1;]" ..
					"label[0,0;Input material]" ..
					 "list[current_name;micro;0,1;1,1;]" ..
					"label[0,1;Rest/microblocks]" ..
					 "field[0.3,2.5;1,1;max_offered;Max:;${max_offered}]" ..
					 "button[1,2;1,1;Set;Set]" ..
					 "list[current_name;recycle;0,3;1,1;]" ..
					"label[0,3;Recycle output]" ..
					 "list[current_name;output;2,0;7,4;]" ..
					 "list[current_player;main;1,5;8,4;]");
		end,

		can_dig = function(pos,player)
			return circular_saw.can_dig(pos, player);
		end,

		-- Set owner of this circular saw
		after_place_node = function(pos, placer)
			local meta = minetest.env:get_meta(pos);
			
			meta:set_string("owner",  (placer:get_player_name() or ""));
			meta:set_string("infotext",  "Circular saw is empty (owned by " .. (placer:get_player_name() or "") .. ")");
		end,

		-- The amount of items offered per shape can be configured
		on_receive_fields = function(pos, formname, fields, sender)
			return circular_saw.on_receive_fields(pos, formname, fields, sender);
		end,

		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			return circular_saw.allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player);     
		end,

		-- Only input- and recycle-slot are intended as input slots
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			return circular_saw.allow_metadata_inventory_put(pos, listname, index, stack, player); 
		end,

		-- Taking is allowed from all slots (even the internal microblock slot); moving is forbidden

		-- Putting something in is slightly more complicated than taking anything because we have to make sure it is of a suitable material
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			return circular_saw.on_metadata_inventory_put(pos, listname, index, stack, player);
		end,

		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			return circular_saw.on_metadata_inventory_take(pos, listname, index, stack, player);
		end

})
