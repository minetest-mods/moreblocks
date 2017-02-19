--[[
More Blocks: conversion

Copyright (c) 2011-2017 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Function to convert all stairs/slabs/etc nodes from
-- inverted, wall, etc to regular + 6d facedir

local dirs1 = {21, 20, 23, 22, 21}
local dirs2 = {15, 8, 17, 6, 15}
local dirs3 = {14, 11, 16, 5, 14}

function stairsplus:register_6dfacedir_conversion(modname, material)
	--print("Register stairsplus 6d facedir conversion")
	--print('ABM for '..modname..' "'..material..'"')

	local objects_list1 = {
		modname.. ":slab_" ..material.. "_inverted",
		modname.. ":slab_" ..material.. "_quarter_inverted",
		modname.. ":slab_" ..material.. "_three_quarter_inverted",
		modname.. ":stair_" ..material.. "_inverted",
		modname.. ":stair_" ..material.. "_wall",
		modname.. ":stair_" ..material.. "_wall_half",
		modname.. ":stair_" ..material.. "_wall_half_inverted",
		modname.. ":stair_" ..material.. "_half_inverted",
		modname.. ":stair_" ..material.. "_right_half_inverted",
		modname.. ":panel_" ..material.. "_vertical",
		modname.. ":panel_" ..material.. "_top",
	}

	local objects_list2 = {
		modname.. ":slab_" ..material.. "_wall",
		modname.. ":slab_" ..material.. "_quarter_wall",
		modname.. ":slab_" ..material.. "_three_quarter_wall",
		modname.. ":stair_" ..material.. "_inner_inverted",
		modname.. ":stair_" ..material.. "_outer_inverted",
		modname.. ":micro_" ..material.. "_top"
	}

	for _, object in pairs(objects_list1) do
		local flip_upside_down = false
		local flip_to_wall = false

		local dest_object = object

		if string.find(dest_object, "_inverted") then
			flip_upside_down = true
			dest_object = string.gsub(dest_object, "_inverted", "")
		end

		if string.find(object, "_top") then
			flip_upside_down = true
			dest_object = string.gsub(dest_object, "_top", "")
		end

		if string.find(dest_object, "_wall") then
			flip_to_wall = true
			dest_object = string.gsub(dest_object, "_wall", "")
		end

		if string.find(dest_object, "_vertical") then
			flip_to_wall = true
			dest_object = string.gsub(dest_object, "_vertical", "")
		end

		if string.find(dest_object, "_half") and not string.find(dest_object, "_right_half") then
			dest_object = string.gsub(dest_object, "_half", "_right_half")
		elseif string.find(dest_object, "_right_half") then
			dest_object = string.gsub(dest_object, "_right_half", "_half")
		end

		--print("    +---> convert " ..object)
		--print("    |     to " ..dest_object)

		minetest.register_abm({
			nodenames = {object},
			interval = 1,
			chance = 1,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local fdir = node.param2 or 0
				local nfdir

				if flip_upside_down and not flip_to_wall then
					nfdir = dirs1[fdir + 2]
				elseif flip_to_wall and not flip_upside_down then
					nfdir = dirs2[fdir + 1]
				elseif flip_to_wall and flip_upside_down then
					nfdir = dirs3[fdir + 2]
				end
				minetest.set_node(pos, {name = dest_object, param2 = nfdir})
			end
		})
	end

	for _, object in pairs(objects_list2) do
		local flip_upside_down = false
		local flip_to_wall = false

		local dest_object = object

		if string.find(dest_object, "_inverted") then
			flip_upside_down = true
			dest_object = string.gsub(dest_object, "_inverted", "")
		end

		if string.find(dest_object, "_top") then
			flip_upside_down = true
			dest_object = string.gsub(dest_object, "_top", "")
		end

		if string.find(dest_object, "_wall") then
			flip_to_wall = true
			dest_object = string.gsub(dest_object, "_wall", "")
		end

		--print("    +---> convert " ..object)
		--print("    |     to " ..dest_object)

		minetest.register_abm({
			nodenames = {object},
			interval = 1,
			chance = 1,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local fdir = node.param2
				local nfdir = 20

				if flip_upside_down and not flip_to_wall then
					nfdir = dirs1[fdir + 1]
				elseif flip_to_wall and not flip_upside_down then
					nfdir = dirs2[fdir + 2]

				end
				minetest.set_node(pos, {name = dest_object, param2 = nfdir})
			end
		})
	end
end
