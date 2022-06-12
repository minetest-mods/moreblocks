local function is_glasslike(def)
	return #def.tiles > 1 and (
		def.drawtype == "glasslike_framed" or
		def.drawtype == "glasslike_framed_optional"
	)
end

function moreblocks.api.register_node_and_stairs(mod, name, def)
	local itemstring = ("%s:%s"):format(mod, name)
	minetest.register_node(itemstring, def)

	-- Use the primary tile for all sides of cut glasslike nodes.
	-- This makes them easier to see
	if is_glasslike(def) then
		def = table.copy(def)
		def.tiles = {def.tiles[1]}
	end

	stairsplus:register_all(mod, name, itemstring, {
		description = def.description,
		groups = def.groups,
		tiles = def.tiles,
		sunlight_propagates = def.sunlight_propagates,
		light_source = def.light_source,
		sounds = def.sounds,
	})
end
