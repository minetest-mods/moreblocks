stairsplus.compat = {
	is_legacy_drawtype = function(node)
		local def = minetest.registered_nodes[node]
		return (
			def.drawtype == "mesh" or
			def.drawtype == "plantlike" or
			def.drawtype == "nodebox"
		)
	end,
	is_legacy_paramtype2 = function(node)
		local def = minetest.registered_nodes[node]
		return (
			def.paramtype2 == "color" or
			def.paramtype2 == "colorwallmounted" or
			def.paramtype2 == "glasslikeliquidlevel"
		)
	end,
}

stairsplus.dofile("compat2", "stairs")
stairsplus.dofile("compat2", "old_moreblocks")

-- stairsplus.dofile("compat", "inventory_managers")
-- unified_inventory, sfinv, i3

