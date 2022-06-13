local table_set_all = moreblocks.util.table_set_all

moreblocks.resources.sounds = {}

if moreblocks.has.default then
	table_set_all(moreblocks.resources.sounds, {
		wood = default.node_sound_wood_defaults(),
	})
end
