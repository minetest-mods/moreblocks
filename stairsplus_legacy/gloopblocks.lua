if stairsplus_legacy.has.basic_materials and stairsplus_legacy.settings.basic_materials then
	stairsplus.api.register_alias_force_all("gloopblocks:cement", "basic_materials:cement_block")

else
	stairsplus_legacy.register_legacy("gloopblocks:cement")
end
