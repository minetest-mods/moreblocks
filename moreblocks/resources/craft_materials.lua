local table_set_all = moreblocks.util.table_set_all

moreblocks.resources.craft_materials = {}

if moreblocks.has.bucket then
	table_set_all(moreblocks.resources.craft_materials, {
		bucket_empty = "bucket:bucket_empty",
	})
end

if moreblocks.has.default then
	table_set_all(moreblocks.resources.craft_materials, {
		acacia_tree = "default:acacia_tree",
		aspen_tree = "default:aspen_tree",
		book = "default:book",
		bookshelf = "default:bookshelf",
		brick = "default:brick",
		bronze_ingot = "default:bronze_ingot",
		cactus = "default:cactus",
		chest = "default:chest",
		chest_locked = "default:chest_locked",
		coal_lump = "default:coal_lump",
		cobble = "default:cobble",
		copper_block = "default:copperblock",
		copper_ingot = "default:copper_ingot",
		desert_cobble = "default:desert_cobble",
		desert_stone = "default:desert_stone",
		dirt = "default:dirt",
		dirt_with_grass = "default:dirt_with_grass",
		dry_shrub = "default:dry_shrub",
		fence_jungle_wood = "default:fence_junglewood",
		glass = "default:glass",
		gold_ingot = "default:gold_ingot",
		jungle_grass = "default:junglegrass",
		jungle_tree = "default:jungletree",
		jungle_wood = "default:junglewood",
		mossy_cobble = "default:mossycobble",
		obsidian = "default:obsidian",
		obsidian_glass = "default:obsidian_glass",
		pine_tree = "default:pine_tree",
		sandstone = "default:sandstone",
		steel_ingot = "default:steel_ingot",
		stick = "default:stick",
		stone_brick = "default:stonebrick",
		stone = "default:stone",
		torch = "default:torch",
		trap_material = "default:mese_crystal_fragment",
		tree = "default:tree",
		wood = "default:wood",
	})
end

if moreblocks.has.screwdriver then
	table_set_all(moreblocks.resources.craft_materials, {
		screwdriver = "screwdriver:screwdriver",
	})
elseif moreblocks.has.rhotator then
	table_set_all(moreblocks.resources.craft_materials, {
		screwdriver = "rhotator:screwdriver_multi",
	})
end

if moreblocks.has.vessels then
	table_set_all(moreblocks.resources.craft_materials, {
		glass_bottle = "vessels:glass_bottle",
		vessels_shelf = "vessels:shelf",
	})
end
