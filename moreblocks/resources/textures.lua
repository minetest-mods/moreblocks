local table_set_all = moreblocks.util.table_set_all

moreblocks.resources.textures = {}

if moreblocks.has.default then
	table_set_all(moreblocks.resources.textures, {
		desert_stone = "default_desert_stone.png",
		glass = "default_glass.png",
		glass_detail = "default_glass_detail.png",
		obsidian = "default_obsidian.png",
		obsidian_glass = "default_obsidian_glass.png",
		obsidian_glass_detail = "default_obsidian_glass_detail.png",
		sandstone = "default_sandstone.png",
		stone = "default_stone.png",
		wood = "default_wood.png",
	})
end
