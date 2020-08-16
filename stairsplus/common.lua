--[[
More Blocks: registrations

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.S

local descriptions = {
	["micro"] = S("%s Microblock"),
	["slab"] = S("%s Slab"),
	["slope"] = S("%s Slope"),
	["panel"] = S("%s Panel"),
	["stair"] = S("%s Stairs"),
}

stairsplus.register_single = function(category, alternate, info, modname, subname, recipeitem, fields)
	local src_def = minetest.registered_nodes[recipeitem] or {}
	local desc_base = descriptions[category]:format(fields.description)
	local def = {}

	if category ~= "slab" then
		def = table.copy(info)
	end

	-- copy fields to def
	for k, v in pairs(fields) do
		def[k] = v
	end

	def.drawtype = "nodebox"
	def.paramtype = "light"
	def.paramtype2 = def.paramtype2 or "facedir"
	if def.use_texture_alpha == nil then
		def.use_texture_alpha = src_def.use_texture_alpha
	end

	-- This makes node rotation work on placement
	def.place_param2 = nil

	-- Darken light sources slightly to make up for their smaller visual size
	def.light_source = math.max(0, (def.light_source or 0) - 1)

	def.on_place = minetest.rotate_node
	def.groups = stairsplus:prepare_groups(fields.groups)

	if category == "slab" then
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
	else
		def.description = desc_base
		if category == "slope" then
			def.drawtype = "mesh"
		elseif category == "stair" and alternate == "" then
			def.groups.stair = 1
		end
	end

	if fields.drop and not (type(fields.drop) == "table") then
		def.drop = modname.. ":" .. category .. "_" .. fields.drop .. alternate
	end

	minetest.register_node(":" ..modname.. ":" .. category .. "_" .. subname .. alternate, def)
	stairsplus.register_recipes(category, alternate, modname, subname, recipeitem)
end
