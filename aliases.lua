--[[
More Blocks: alias definitions

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- More Blocks aliases:
core.register_alias("sweeper", "moreblocks:sweeper")
core.register_alias("circular_saw", "moreblocks:circular_saw")
core.register_alias("jungle_stick", "moreblocks:jungle_stick")

-- Old block/item replacement:
core.register_alias("moreblocks:oerkkiblock", "default:mossycobble")
core.register_alias("moreblocks:screwdriver", "screwdriver:screwdriver")

-- Node and item renaming:
core.register_alias("moreblocks:stone_bricks", "default:stonebrick")
core.register_alias("moreblocks:stonebrick", "default:stonebrick")
core.register_alias("moreblocks:junglewood", "default:junglewood")
core.register_alias("moreblocks:jungle_wood", "default:junglewood")
core.register_alias("moreblocks:fence_junglewood", "default:fence_junglewood")
core.register_alias("moreblocks:fence_jungle_wood", "default:fence_junglewood")
core.register_alias("moreblocks:jungle_stick", "default:stick")

for _, t in pairs(circular_saw.names) do
	core.register_alias("moreblocks:" .. t[1] .. "_jungle_wood" .. t[2],
			"moreblocks:" .. t[1] .. "_junglewood" .. t[2])
end
core.register_alias("moreblocks:horizontaltree", "moreblocks:horizontal_tree")
core.register_alias("moreblocks:horizontaljungletree", "moreblocks:horizontal_jungle_tree")
core.register_alias("moreblocks:stonesquare", "moreblocks:stone_tile")
core.register_alias("moreblocks:circlestonebrick", "moreblocks:circle_stone_bricks")
core.register_alias("moreblocks:ironstonebrick", "moreblocks:iron_stone_bricks")
core.register_alias("moreblocks:coalstone", "moreblocks:coal_stone")
core.register_alias("moreblocks:ironstone", "moreblocks:iron_stone")
core.register_alias("moreblocks:woodtile", "moreblocks:wood_tile")
core.register_alias("moreblocks:woodtile_full", "moreblocks:wood_tile_full")
core.register_alias("moreblocks:woodtile_centered", "moreblocks:wood_tile_centered")
core.register_alias("moreblocks:woodtile_up", "moreblocks:wood_tile_offset")
core.register_alias("moreblocks:wood_tile_up", "moreblocks:wood_tile_offset")
core.register_alias("moreblocks:woodtile_down", "moreblocks:wood_tile_down")
core.register_alias("moreblocks:woodtile_left", "moreblocks:wood_tile_left")
core.register_alias("moreblocks:woodtile_right", "moreblocks:wood_tile_right")
core.register_alias("moreblocks:coalglass", "moreblocks:coal_glass")
core.register_alias("moreblocks:ironglass", "moreblocks:iron_glass")
core.register_alias("moreblocks:glowglass", "moreblocks:glow_glass")
core.register_alias("moreblocks:superglowglass", "moreblocks:super_glow_glass")
core.register_alias("moreblocks:trapglass", "moreblocks:trap_glass")
core.register_alias("moreblocks:trapstone", "moreblocks:trap_stone")
core.register_alias("moreblocks:cactuschecker", "moreblocks:cactus_checker")
core.register_alias("moreblocks:coalchecker", "moreblocks:coal_checker")
core.register_alias("moreblocks:ironchecker", "moreblocks:iron_checker")
core.register_alias("moreblocks:cactusbrick", "moreblocks:cactus_brick")
core.register_alias("moreblocks:cleanglass", "moreblocks:clean_glass")
core.register_alias("moreblocks:emptybookshelf", "moreblocks:empty_bookshelf")
core.register_alias("moreblocks:junglestick", "moreblocks:jungle_stick")
core.register_alias("moreblocks:splitstonesquare","moreblocks:split_stone_tile")
core.register_alias("moreblocks:allfacestree","moreblocks:all_faces_tree")
core.register_alias("moreblocks:empty_bookshelf","moreblocks:empty_shelf")
core.register_alias("moreblocks:split_stone_tile_alt","moreblocks:checker_stone_tile")

-- ABM for horizontal trees (fix facedir):
local horizontal_tree_convert_facedir = {7, 12, 9, 18}

core.register_abm({
	nodenames = {"moreblocks:horizontal_tree","moreblocks:horizontal_jungle_tree"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		if node.name == "moreblocks:horizontal_tree" then
			node.name = "default:tree"
		else
			node.name = "default:jungletree"
		end
		node.param2 = node.param2 < 3 and node.param2 or 0
		core.set_node(pos, {
			name = node.name,
			param2 = horizontal_tree_convert_facedir[node.param2 + 1]
		})
	end,
})

core.register_lbm({
	name = "moreblocks:reduce_wood_tile_redundancy",
	nodenames = {
		"moreblocks:wood_tile_left",
		"moreblocks:wood_tile_down",
		"moreblocks:wood_tile_right",
		"moreblocks:wood_tile_flipped",
	},
	action = function(pos, node)
		if node.name:find("left") then
			core.set_node(pos, {name = "moreblocks:wood_tile_offset", param2=1})
		elseif node.name:find("down") then
			core.set_node(pos, {name = "moreblocks:wood_tile_offset", param2=2})
		elseif node.name:find("right") then
			core.set_node(pos, {name = "moreblocks:wood_tile_offset", param2=3})
		else -- wood_tile_flipped
			core.set_node(pos, {name = "moreblocks:wood_tile", param2=1})
		end
		core.log('action', "LBM replaced " .. node.name ..
			" at " .. core.pos_to_string(pos))
	end,
})
