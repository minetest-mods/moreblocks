local materials = stairsplus_legacy.materials

if materials.concrete_block and materials.concrete_block ~= "prefab:concrete" then
	local slab_name = stairsplus.api.format_name(materials.concrete_block, "slab_8")
	local stair_name = stairsplus.api.format_name(materials.concrete_block, "stair")

	minetest.register_alias_force("prefab:concrete_slab", slab_name)
	minetest.register_alias_force("prefab:concrete_stair", stair_name)
end
