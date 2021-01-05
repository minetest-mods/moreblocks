--[[
More Blocks: redefinitions of default stuff

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local modname = minetest.get_current_modname()

-- Redefine some of the default crafting recipes to be more productive

-- Auxiliary function: take a recipe as returned by get_all_craft_recipes
-- and turn it into a table that can be used to clear a craft or declare a new one
local reconstruct_internal_craft = function(recipe)
	local recp = {
		{ "", "", "" },
		{ "", "", "" },
		{ "", "", "" },
	}
	local width = recipe.width
	for idx, item in pairs(recipe.items) do
		local row = math.ceil(idx / width)
		local col = idx - (row-1)*width
		recp[row][col] = item
	end
	return recp
end

-- Change the amount produced by recipe by apply func to the old amount
local change_recipe_amount = function(product, recipe, func)
	-- if width == 0, this is a shapeless recipe, for which the
	-- internal and Lua API recipe table is the same.
	-- Otherwise we need to reconstruct the table for the shaped recipe.
	local shapeless = (recipe.width == 0)
	local recp = shapeless and recipe.items or reconstruct_internal_craft(recipe)

	local oldamount = tonumber(recipe.output:match(" [0-9]+$") or "1")

	local newamount = func(oldamount)

	-- remove old crafting recipe
	local redo = { recipe = recp }
	-- preserve shapelessness
	if shapeless then
		redo.type = "shapeless"
	end
	minetest.clear_craft(redo)

	-- new output
	redo.output = ("%s %d"):format(product, newamount)
	minetest.register_craft(redo)

	minetest.log("action", ("[MOD]%s: recipe for %s production: %d => %d"):format(modname, product, oldamount, newamount))
end

local increase_craft_production = function(product, func)
	local recipes = minetest.get_all_craft_recipes(product)
	for _, r in pairs(recipes) do
		if r.type == "normal" or r.method == "normal" then
			change_recipe_amount(product, r, func)
		end
	end
end

-- Increase the crafting production according to the rules from the table, which is in the form:
-- {
--   { detector, amount changing function }
--   { detector, amount changing function }
-- }
-- TODO: consider exporting this function to other mods
local increase_craft_production_table = function(map_table)
	for product, _ in pairs(minetest.registered_items) do
		for _, tab in pairs(map_table) do
			local detector = tab[1]
			local func = tab[2]
			if detector(product) then
				increase_craft_production(product, func)
				-- only apply one boost
				break
			end
		end
	end
end

increase_craft_production_table({
	{ function(n) return n:match('^default:sign_wall') end, function(old) return old + 1 end },
	{ function(n) return n == 'default:paper' end, function(old) return old*4 end },
	{ function(n) return n:match('^carts:.*rail$') or n:match('^default:.*rail$') end, function(old) return old + old/2 end },
})

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.10, -- Tool repair buff (10% bonus instead of 2%).
})
