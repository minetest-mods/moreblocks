if stairsplus_legacy.has.basic_materials and stairsplus_legacy.settings.basic_materials then
	stairsplus.api.register_alias_force_all("prefab:concrete", "basic_materials:concrete_block")

elseif stairsplus_legacy.has.technic and stairsplus_legacy.settings.technic then
	stairsplus.api.register_alias_force_all("prefab:concrete", "technic:concrete")

else
	stairsplus_legacy.register_legacy("prefab:concrete")
end
