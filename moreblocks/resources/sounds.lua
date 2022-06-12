local table_set_all = moreblocks.util.table_set_all

moreblocks.resources.sounds = {}

if moreblocks.has.default then
	table_set_all(moreblocks.resources.sounds, {
		dirt = default.node_sound_dirt_defaults(),
		glass = default.node_sound_glass_defaults(),
		leaves = default.node_sound_leaves_defaults(),
		metal = default.node_sound_metal_defaults(),
		stone = default.node_sound_stone_defaults(),
		wood = default.node_sound_wood_defaults(),
	})
end
