local S = moreblocks.S
local cm = moreblocks.resources.craft_materials

function moreblocks.api.register_trap(mod, name, base, redef)
	local def = table.copy(minetest.registered_nodes[base])

	def.description = S("Trap @1", def.description)

	if def.short_description then
		def.short_description = S("Trap @1", def.short_description)
	end

	for i, tile in ipairs(def.tiles) do
		def.tiles[i] = tile .. "^moreblocks_trap_box.png"
	end

	if def.drawtype ~= "glasslike_framed_optional" then
		def.drawtype = "glasslike_framed"
	end

	def.walkable = false
	def.paramtype = "light"
	def.is_ground_content = false

	redef = redef or {}
	for k, v in pairs(redef) do
		def[k] = v
	end

	local itemstring = ("%s:%s"):format(mod, name)
	minetest.register_node(itemstring, def)

	if cm.trap_material then
		minetest.register_craft({
			output = itemstring,
			type = "shapeless",
			recipe = {cm.trap_material, base},
		})
	end
end
