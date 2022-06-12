local S = moreblocks.S

function moreblocks.api.register_all_faces(itemstring, base, redef)
	local def = table.copy(minetest.registered_nodes[base])

	def.tiles = {def.tiles[1]}
	def.description = S("All-faces @1", def.description)

	if def.short_description then
		def.short_description = S("All-faces @1", def.short_description)
	end

	redef = redef or {}
	for k, v in pairs(redef) do
		def[k] = v
	end

	minetest.register_node(itemstring, def)

	minetest.register_craft({
		output = itemstring .. " 8",
		recipe = {
			{base, base, base},
			{base, "", base},
			{base, base, base},
		}
	})
end
