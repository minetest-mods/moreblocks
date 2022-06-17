-- luacheck: read globals unified_inventory

if not stairsplus.has.unified_inventory then
	return
end

unified_inventory.register_craft_type("stairsplus", {
	-- ^ Unique identifier for `register_craft`
	description = "Stairs+ craft schema",
	-- ^ Text shown below the crafting arrow
	icon = "dummy.png",
	-- ^ Image shown above the crafting arrow
	width = 3,
	height = 3,
	-- ^ Maximal input dimensions of the recipes
	uses_crafting_grid = true,
})

local function convert_schema_recipe_item(item)
	if item == "" then
		return item
	end

	local name, count = item:match("^([^ ]+) (%d+)")
	if not name then
		name = item
	end

	count = tonumber(count)

	error("more logic here")

	if count then
		return ("%s %s"):format(name, count)
	else
		return name
	end
end

stairsplus.api.register_on_register_craft_schema(function(schema)
	local recipe = table.copy(schema)

	recipe.output = convert_schema_recipe_item(recipe.output)
end)
