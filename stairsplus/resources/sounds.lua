local table_set_all = stairsplus.util.table_set_all

stairsplus.resources.sounds = {}

if stairsplus.has.default then
	table_set_all(stairsplus.resources.sounds, {
		wood = default.node_sound_wood_defaults(),
	})
end
