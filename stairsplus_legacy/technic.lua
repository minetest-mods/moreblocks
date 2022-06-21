local materials = stairsplus_legacy.materials

if materials.concrete_block and materials.concrete_block ~= "technic:concrete" then
	stairsplus.api.register_alias_all("technic:concrete", materials.concrete_block)
elseif minetest.registered_nodes["technic:concrete"] then
	stairsplus_legacy.register_legacy("technic:concrete")
end

if materials.brass_block and materials.brass_block ~= "technic:brass_block" then
	stairsplus.api.register_alias_all("technic:brass_block", materials.brass_block)
elseif minetest.registered_nodes["technic:brass_block"] then
	stairsplus_legacy.register_legacy("technic:brass_block")
end
