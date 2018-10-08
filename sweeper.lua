local S = moreblocks.intllib
local check_protection = moreblocks.check_protection
local sweepables = {}

--
-- functional sweeper
--
minetest.register_craftitem("moreblocks:sweeper", {
	description = S("Sweeper"),
	inventory_image = "moreblocks_sweeper.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			-- do nothing if it's not a node
			return
		end

		local node = minetest.get_node(pointed_thing.under)
		local ndef = minetest.registered_nodes[node.name]
		local sweepable = sweepables[node.name] or (ndef and ndef.on_sweep)

		if not sweepable then
			return
		end

		if check_protection(pointed_thing.under, user and user:get_player_name(), "sweeper", "sweep " .. node.name) then
			return
		end

		sweepable(pointed_thing.under, node)
	end
})

--
-- register sweepable node handler
--
function moreblocks:register_sweepable(node_name, callback)
	sweepables[node_name] = callback
end



------------------------------------
-- DEMO CODE                      --
-- TODO: REMOVE AFTER TESTING     --
-- Sweepable mossycobble example: --

-- use register_sweepable function
moreblocks:register_sweepable("default:mossycobble", function (pos, node)
	local meta = minetest.get_meta(pos)
	local sweeps = meta:get_int('sweeps') + 1

	-- hit 3 times to clean
	if sweeps > 2 then
		-- set clean node
		meta:set_int('sweeps', 0)
		minetest.swap_node(pos, { name = "default:cobble" })
		return true
	end

	meta:set_int('sweeps', sweeps)

	return false
end)

-- or when registering node
--[[ 
minetest.register_node("default:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = {"default_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),

	on_sweep = function (pos, node)
		-- do the magic here
	end,
})
]]

-------------------------------------
