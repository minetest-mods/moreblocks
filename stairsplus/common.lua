--[[
More Blocks: registrations

Copyright © 2011-2019 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.S


stairsplus.register_single = function(category, alternate, info, modname, subname, recipeitem, fields)
	local descriptions = {
		["micro"] = S("Microblock"),
		["slab"] = S("Slab"),
		["slope"] = S("Slope"),
		["panel"] = S("Panel"),
		["stair"] = S("Stairs"),
	}
	local def = {}
	if category ~= "slab" then
		def = table.copy(info)
	end

	for k, v in pairs(fields) do
		def[k] = v
	end
	def.drawtype = "nodebox"
	if category == "slope" then
		def.drawtype = "mesh"
	end
	def.paramtype = "light"
	def.paramtype2 = def.paramtype2 or "facedir"

	-- This makes node rotation work on placement
	def.place_param2 = nil

	def.on_place = minetest.rotate_node
	if category ~= "slab" then
		def.description = S("%s " .. descriptions[category]):format(fields.description)
	else
		local desc_base = S("%s " .. descriptions[category]):format(fields.description)
		if type(info) ~= "table" then
			def.node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, (info/16)-0.5, 0.5},
			}
			def.description = ("%s (%d/16)"):format(desc_base, info)
		else
			def.node_box = {
				type = "fixed",
				fixed = info,
			}
			def.description = desc_base .. alternate:gsub("_", " "):gsub("(%a)(%S*)", function(a, b) return a:upper() .. b end)
		end
	end
	def.groups = stairsplus:prepare_groups(fields.groups)
	if category == "stair" and alternate == "" then
		def.groups.stair = 1
	end
	if fields.drop and not (type(fields.drop) == "table") then
		def.drop = modname.. ":" .. category .. "_" .. fields.drop .. alternate
	end
	minetest.register_node(":" ..modname.. ":" .. category .. "_" .. subname .. alternate, def)
	stairsplus.register_recipes(category, alternate, modname, subname, recipeitem)
end
