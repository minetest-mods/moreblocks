-- for registering recipe schemas
local api = stairsplus.api

api.registered_recipe_schemas = {}
api.registered_on_register_craft_schemas = {}

local registered_schemas_by_node = {}

local function is_valid_output(item, shapes)
	local item_name = item:match("^([^ ]+)")

	return item_name and (shapes[item_name] or item_name == "node" or item_name:match(":"))
end

local function is_valid_item(item, shapes)
	return is_valid_output(item, shapes) or item == ""
end

local function verify_schema(schema)
	local problems = {}

	if not (schema.type == "shaped" or schema.type == "shapeless" or schema.type == nil) then
		table.insert(problems, ("unimplemented schema type %q"):format(schema.type))
	end

	if not is_valid_output(schema.output, api.registered_shapes) then
		table.insert(problems, ("don't know how to handle output %q"):format(schema.output))
	end

	if schema.replacements then
		for _, replacement in ipairs(schema.replacements) do
			for _, item in ipairs(replacement) do
				if not is_valid_item(item, api.registered_shapes) then
					table.insert(problems, ("don't know how to handle replacement item %q"):format(item))
				end
			end
		end
	end

	if schema.type == "shapeless" then
		for _, item in ipairs(schema.recipe) do
			if not is_valid_item(item, api.registered_shapes) then
				table.insert(problems, ("don't know how to handle craft item %q"):format(item))
			end
		end

	else
		for _, row in ipairs(schema.recipe) do
			for _, item in ipairs(row) do
				if not is_valid_item(item, api.registered_shapes) then
					table.insert(problems, ("don't know how to handle craft item %q"):format(item))
				end
			end
		end
	end

	if #problems > 0 then
		return table.concat(problems, ", ")
	end
end

local function has_the_right_shapes(schema, shapes)
	if not is_valid_output(schema.output, shapes) then
		return false
	end

	if schema.replacements then
		for _, replacement in ipairs(schema.replacements) do
			for _, item in ipairs(replacement) do
				if not is_valid_item(item, shapes) then
					return false
				end
			end
		end
	end

	if schema.type == "shapeless" then
		for _, item in ipairs(schema.recipe) do
			if not is_valid_item(item, shapes) then
				return false
			end
		end

	elseif schema.type == "shaped" or schema.type == nil then
		for _, row in ipairs(schema.recipe) do
			for _, item in ipairs(row) do
				if not is_valid_item(item, shapes) then
					return false
				end
			end
		end
	end

	return true
end

local function register_for_schema(node, schema)
	stairsplus.log("verbose", "using schema %s w/ node %s", minetest.write_json(schema), node)

	local recipe = table.copy(schema)

	recipe.output = api.get_schema_recipe_item(node, recipe.output)

	if recipe.replacements then
		for _, replacement in ipairs(recipe.replacements) do
			for i, item in ipairs(replacement) do
				replacement[i] = api.get_schema_recipe_item(node, item)
			end
		end
	end

	if recipe.type == "shapeless" then
		for i, item in ipairs(recipe.recipe) do
			recipe.recipe[i] = api.get_schema_recipe_item(node, item)
		end

	elseif recipe.type == "shaped" or recipe.type == nil then
		for _, row in ipairs(recipe.recipe) do
			for i, item in ipairs(row) do
				row[i] = api.get_schema_recipe_item(node, item)
			end
		end
	end

	stairsplus.log("info", "registering recipe %s", minetest.write_json(recipe))

	minetest.register_craft(recipe)
end

function api.register_on_register_craft_schema(func)
	table.insert(api.registered_on_register_craft_schemas, func)
end

function api.register_craft_schema(schema)
	local problems = verify_schema(schema)

	if problems then
		error(problems)
	end

	stairsplus.log("info", "registering craft schema %s", minetest.write_json(schema))

	table.insert(api.registered_recipe_schemas, schema)

	for node, shapes in pairs(api.shapes_by_node) do
		local registered_schemas = registered_schemas_by_node[node] or {}

		if has_the_right_shapes(schema, shapes) and not registered_schemas[schema] then
			register_for_schema(node, schema)
			registered_schemas[schema] = true
		end

		registered_schemas_by_node[node] = registered_schemas
	end

	for _, func in ipairs(api.registered_on_register_craft_schemas) do
		func(schema)
	end
end

function api.register_schema_crafts_for_node(node)
	local registered_schemas = registered_schemas_by_node[node] or {}

	local shapes = api.get_shapes_hash(node)
	for _, schema in ipairs(api.registered_recipe_schemas) do
		if has_the_right_shapes(schema, shapes) and not registered_schemas[schema] then
			register_for_schema(node, schema)
			registered_schemas[schema] = true
		end
	end

	registered_schemas_by_node[node] = registered_schemas
end

api.register_on_register_single(api.register_schema_crafts_for_node)

local function shapes_match(a, b)
	local a_shapes = api.get_shapes(a)
	local b_shapes = api.get_shapes(b)

	if #a_shapes ~= #b_shapes then
		return false
	end

	for i = 1, #a_shapes do
		if a_shapes[i] ~= b_shapes[i] then
			return false
		end
	end

	return true
end

local function register_cooking_for_shapes(recipe)
	local mod, name = recipe.recipe:match("^([^:]+):(.*)$")

	if mod ~= "group" and not shapes_match(recipe.output, recipe.recipe) then
		error(("error: shapes of %s and %s do not match"):format(recipe.output, recipe.recipe))
	end

	local shapes = api.get_shapes(recipe.output)

	for _, shape in ipairs(shapes) do
		local shape_def = api.registered_shapes[shape]
		local input
		if mod == "group" then
			input = "group:" .. shape_def.name_format:format(name)
		else
			input = api.get_schema_recipe_item(recipe.recipe, shape)
		end

		minetest.register_craft({
			type = "cooking",
			output = api.get_schema_recipe_item(recipe.output, shape),
			recipe = input,
			cooktime = math.max(1.0, (recipe.cooktime or 3) * (shape_def.eighths / 8)),
		})
	end
end

local function register_fuel_for_shapes(recipe)
	local mod, name = recipe.recipe:match("^([^:]+):(.*)$")
	local shapes
	if mod == "group" then
		shapes = api.registered_shapes
	else
		shapes = api.get_shapes_hash(recipe.recipe)
	end

	if not shapes then
		error(("don't know how to handle fuel %s"):format(recipe.recipe))
	end

	for shape in pairs(shapes) do
		local shape_def = api.registered_shapes[shape]
		local input
		if mod == "group" then
			input = "group:" .. shape_def.name_format:format(name)
		else
			input = api.get_schema_recipe_item(recipe.recipe, shape)
		end

		minetest.register_craft({
			type = "fuel",
			recipe = input,
			burntime = math.max(1.0, (recipe.burntime or 1) * (shape_def.eighths / 8)),
		})
	end
end

function api.register_crafts_for_shapes(recipe)
	if recipe.type == "cooking" then
		register_cooking_for_shapes(recipe)

	elseif recipe.type == "fuel" then
		register_fuel_for_shapes(recipe)

	else
		error(("unsupported recipe type %s"):format(recipe.type))
	end
end
