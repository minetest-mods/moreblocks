
minetest.register_alias("circular_saw", "stairsplus:circular_saw")
minetest.register_alias("moreblocks:circular_saw", "stairsplus:circular_saw")

for _, t in pairs(stairsplus.circular_saw.names) do
	minetest.register_alias("moreblocks:" .. t[1] .. "_jungle_wood" .. t[2],
		"stairsplus:" .. t[1] .. "_junglewood" .. t[2])
end
