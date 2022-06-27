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

stairsplus.dofile("compat", "i3")
stairsplus.dofile("compat", "unified_inventory")

stairsplus.dofile("compat", "stairs")
stairsplus.dofile("compat", "old_moreblocks")

