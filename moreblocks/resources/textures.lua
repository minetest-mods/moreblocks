local table_set_all = moreblocks.util.table_set_all

moreblocks.resources.textures = {
	desert_stone = "[combine:16x16^[noalpha^[colorize:#85513e",
	glass = ([[
		[combine:16x16
		:0,0=\[combine\:1x16\^[noalpha\^[colorize\:#FFF
		:0,0=\[combine\:16x1\^[noalpha\^[colorize\:#FFF
		:0,15=\[combine\:16x1\^[noalpha\^[colorize\:#FFF
		:15,0=\[combine\:1x16\^[noalpha\^[colorize\:#FFF
	]]):gsub("%s", ""),
	glass_detail = ([[
		[combine:16x16
		:0,0=\[combine\:1x16\^[noalpha\^[colorize\:#FFF
		:0,0=\[combine\:16x1\^[noalpha\^[colorize\:#FFF
		:0,15=\[combine\:16x1\^[noalpha\^[colorize\:#FFF
		:15,0=\[combine\:1x16\^[noalpha\^[colorize\:#FFF
	]]):gsub("%s", ""),
	obsidian = "default_obsidian.png",
	obsidian_glass = ([[
		[combine:16x16
		:0,0=\[combine\:1x16\^[noalpha\^[colorize\:#000
		:0,0=\[combine\:16x1\^[noalpha\^[colorize\:#000
		:0,15=\[combine\:16x1\^[noalpha\^[colorize\:#000
		:15,0=\[combine\:1x16\^[noalpha\^[colorize\:#000
	]]):gsub("%s", ""),
	obsidian_glass_detail = ([[
		[combine:16x16
		:0,0=\[combine\:1x16\^[noalpha\^[colorize\:#000
		:0,0=\[combine\:16x1\^[noalpha\^[colorize\:#000
		:0,15=\[combine\:16x1\^[noalpha\^[colorize\:#000
		:15,0=\[combine\:1x16\^[noalpha\^[colorize\:#000
	]]):gsub("%s", ""),
	sandstone = "default_sandstone.png",
	stone = "[combine:16x16^[noalpha^[colorize:#686463",
	wood = "[combine:16x16^[noalpha^[colorize:#654321",
}

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
