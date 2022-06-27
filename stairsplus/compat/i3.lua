-- luacheck: read globals i3

if not stairsplus.has.i3 then
	return
end

local api = stairsplus.api

i3.register_craft_type("stairsplus:craft_schema", {
	description = "Stairs+ craft schema",
	icon = "stairsplus_saw_button.png",
})

i3.register_craft_type("stairsplus:circular_saw", {
	description = "Stairs+ circular saw",
	icon = "stairsplus_saw_button.png",
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
		local tmp = {}
		for _, row in ipairs(recipe.recipe) do
			for i, item in ipairs(row) do
				table.insert(tmp, convert_schema_recipe_item(item))
			end
		end
		recipe.recipe = tmp
	end

	i3.register_craft({
		type = "stairsplus:craft_schema",
		result = recipe.output,
		items = recipe.recipe,
	})
end

for _, schema in ipairs(api.registered_recipe_schemas) do
	on_register_craft_schema(schema)
end

api.register_on_register_craft_schema(on_register_craft_schema)

local function on_register_single(node, shaped_name)
	i3.register_craft({
		type = "stairsplus:circular_saw",
		result = shaped_name,
		items = {node},
	})
end

for _, single in ipairs(api.registered_singles) do
	local node, shaped_name = unpack(single)
	on_register_single(node, shaped_name)
end

api.register_on_register_single(on_register_single)


