if stairsplus_legacy.has.basic_materials and stairsplus_legacy.settings.basic_materials then
	stairsplus.api.register_alias_force_all("technic:brass_block", "basic_materials:concrete_block")
	stairsplus.api.register_alias_force_all("technic:brass_block", "basic_materials:brass_block")

else
	stairsplus_legacy.register_legacy("technic:brass_block")
	stairsplus_legacy.register_legacy("technic:concrete")
end

