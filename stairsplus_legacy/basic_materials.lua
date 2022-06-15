-- not every fork of basic_materials has all the nodes
if minetest.registered_nodes["basic_materials:concrete_block"] then
	stairsplus_legacy.register_legacy("basic_materials:concrete_block")
end

if minetest.registered_nodes["basic_materials:cement_block"] then
	stairsplus_legacy.register_legacy("basic_materials:cement_block")
end

if minetest.registered_nodes["basic_materials:brass_block"] then
	stairsplus_legacy.register_legacy("basic_materials:brass_block")
end
