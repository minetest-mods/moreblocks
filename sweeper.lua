local S = moreblocks.intllib
local check_protection = moreblocks.check_protection
local sweepables = {}

-- example sweepable node
-- TODO API for sweepable node registration
sweepables["default:mossycobble"] = function(pos, node)
	-- hit 3 times to clean
	if node.param1 < 2 then
		node.param1 = node.param1 + 1
		minetest.set_node(pos, node)
		return false
	end

	-- set clean node
	minetest.set_node(pos, { name = "default:cobble" })

	return true
end


-- functional sweeper
minetest.register_craftitem("moreblocks:sweeper", {
	description = S("Sweeper"),
	inventory_image = "moreblocks_sweeper.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			-- do nothing if it's not a node
			return
		end

		local node = minetest.get_node(pointed_thing.under)
		local sweepable = sweepables[node.name]

		if not sweepable then
			return
		end

		if check_protection(pointed_thing.under, user:get_player_name(), "sweeper", "sweep " .. node.name) then
			return
		end

		sweepable(pointed_thing.under, node)
	end
})
