local materials = stairsplus_legacy.materials

if materials.cement_block and materials.cement_block ~= "gloopblocks:cement" then
	stairsplus.api.register_alias_all("gloopblocks:cement", materials.cement_block)
elseif minetest.registered_nodes["gloopblocks:cement"] then
	stairsplus_legacy.register_legacy("gloopblocks:cement")
end
