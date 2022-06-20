local S = moreblocks.S

function moreblocks.api.register_no_faces(itemstring, base, redef)
	local def = table.copy(minetest.registered_nodes[base])

	def.tiles = {def.tiles[3]}
	def.description = S("No-faces @1", def.description)

	if def.short_description then
		def.short_description = S("No-faces @1", def.short_description)
	end

	redef = redef or {}
	for k, v in pairs(redef) do
		def[k] = v
	end

	minetest.register_node(itemstring, def)

	minetest.register_craft({
		output = itemstring .. " 9",
		recipe = {
			{base, base, base},
			{base, base, base},
			{base, base, base},
		}
	})
end
