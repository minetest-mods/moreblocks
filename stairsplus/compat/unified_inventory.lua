-- luacheck: read globals unified_inventory

if not stairsplus.has.unified_inventory then
	return
end

local api = stairsplus.api

unified_inventory.register_craft_type("stairsplus:craft_schema", {
	-- ^ Unique identifier for `register_craft`
	description = "Stairs+ craft schema",
	-- ^ Text shown below the crafting arrow
	icon = "stairsplus_saw_button.png",
	-- ^ Image shown above the crafting arrow
	width = 3,
	height = 3,
	-- ^ Maximal input dimensions of the recipes
	uses_crafting_grid = true,
})

unified_inventory.register_craft_type("stairsplus:circular_saw", {
	-- ^ Unique identifier for `register_craft`
	description = "Stairs+ circular saw",
	-- ^ Text shown below the crafting arrow
	icon = "stairsplus_saw_button.png",
	-- ^ Image shown above the crafting arrow
	width = 1,
	height = 1,
	-- ^ Maximal input dimensions of the recipes
	uses_crafting_grid = true,
})

unified_inventory.register_category("stairsplus:cuttable", {
	symbol = "stairsplus:circular_saw",
	label = "Cuttable in the circular saw",
	index = 0,
	items = {}
})

unified_inventory.register_category("stairsplus:cut_node", {
	symbol = "stairsplus:circular_saw",
	label = "Nodes cut in the circular saw",
	index = 0,
	items = {}
})

local function convert_schema_recipe_item(item)
	if item == "" or item:match(":") then
		return item
	end

	local name, count = item:match("^([^ ]+) (%d+)")
	if not name then
		name = item
	end

	count = tonumber(count)

	if name == "node" then
		name = "mapgen_stone"
		if count then
			return ("%s %s"):format(name, count)
		else
			return name
		end
	else
		if count then
			return ("group:shape_%s %s"):format(name, count)
		else
			return ("group:shape_%s"):format(name)
		end
	end
end

local function on_register_craft_schema(schema)
	local recipe = table.copy(schema)

	recipe.output = convert_schema_recipe_item(recipe.output)

	if recipe.replacements then
		for _, replacement in ipairs(recipe.replacements) do
			for i, item in ipairs(replacement) do
				replacement[i] = convert_schema_recipe_item(item)
			end
		end
	end

	if recipe.type == "shapeless" then
		for i, item in ipairs(recipe.recipe) do
			recipe.recipe[i] = convert_schema_recipe_item(item)
		end

	elseif recipe.type == "shaped" or recipe.type == nil then
		for _, row in ipairs(recipe.recipe) do
			for i, item in ipairs(row) do
				row[i] = convert_schema_recipe_item(item)
			end
		end
	end

	unified_inventory.register_craft({
		output = recipe.output,
		type = "stairsplus:craft_schema",
		items = recipe.recipe,
		width = 3,
	})
end

for _, schema in ipairs(api.registered_recipe_schemas) do
	on_register_craft_schema(schema)
end

api.register_on_register_craft_schema(on_register_craft_schema)

local function on_register_single(node, shaped_name)
	unified_inventory.register_craft({
		output = shaped_name,
		type = "stairsplus:circular_saw",
		items = {node},
		width = 1,
	})

	unified_inventory.add_category_item("stairsplus:cuttable", node)
	unified_inventory.add_category_item("stairsplus:cut_node", shaped_name)
end

for _, single in ipairs(api.registered_singles) do
	local node, shaped_name = unpack(single)
	on_register_single(node, shaped_name)
end

api.register_on_register_single(on_register_single)
