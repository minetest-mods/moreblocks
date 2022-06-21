stairsplus_legacy.materials = {}

if stairsplus_legacy.has.prefab then
	if minetest.registered_nodes["prefab:concrete"] then
		stairsplus_legacy.materials.concrete_block = "prefab:concrete"
	end
end

if stairsplus_legacy.has.gloopblocks then
	if minetest.registered_nodes["gloopblocks:cement"] then
		stairsplus_legacy.materials.cement_block = "gloopblocks:cement"
	end
end

if stairsplus_legacy.has.technic then
	if minetest.registered_nodes["technic:brass_block"] then
		stairsplus_legacy.materials.brass_block = "technic:brass_block"
	end
	if minetest.registered_nodes["technic:concrete"] then
		stairsplus_legacy.materials.concrete_block = "technic:concrete"
	end
end

if stairsplus_legacy.has.basic_materials then
	if minetest.registered_nodes["basic_materials:brass_block"] then
		stairsplus_legacy.materials.brass_block = "basic_materials:brass_block"
	end
	if minetest.registered_nodes["basic_materials:cement_block"] then
		stairsplus_legacy.materials.cement_block = "basic_materials:cement_block"
	end
	if minetest.registered_nodes["basic_materials:concrete_block"] then
		stairsplus_legacy.materials.concrete_block = "basic_materials:concrete_block"
	end
end
