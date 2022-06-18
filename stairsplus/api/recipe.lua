-- for registering recipe schemas
local api = stairsplus.api

api.registered_recipe_schemas = {}
api.registered_on_register_craft_schemas = {}

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

function api.register_on_register_craft_schema(func)
	table.insert(api.registered_on_register_craft_schemas, func)
end

function api.register_craft_schema(schema)
	local problems = verify_schema(schema)

	if problems then
		error(problems)
	end

	stairsplus.log("info", "registering craft schema %s", minetest.serialize(schema):sub(#("return ")))

	table.insert(api.registered_recipe_schemas, schema)

	for _, func in ipairs(api.registered_on_register_craft_schemas) do
		func(schema)
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

	stairsplus.log("info", "registering recipe %s", minetest.serialize(recipe):sub(#("return ")))

	minetest.register_craft(recipe)
end

function api.register_schema_crafts_for_node(node)
	stairsplus.log("info", "registering schema crafts for %q", node)
	local shapes = api.get_shapes_hash(node)
	for _, schema in ipairs(api.registered_recipe_schemas) do
		if has_the_right_shapes(schema, shapes) then
			stairsplus.log("verbose", "using schema %s", minetest.serialize(schema):sub(#("return ")))
			register_for_schema(node, schema)
		end
	end
end

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

function api.register_crafts_for_shapes(recipe)
	if recipe.type == "cooking" then
		assert(
			shapes_match(recipe.output, recipe.recipe),
			("error: shapes of %s and %s do not match"):format(recipe.output, recipe.recipe)
		)

		local shapes = api.get_shapes(recipe.recipe)

		for _, shape in ipairs(shapes) do
			minetest.register_craft({
				type = "cooking",
				output = api.get_schema_recipe_item(recipe.output, shape),
				recipe = api.get_schema_recipe_item(recipe.recipe, shape),
				cooktime = recipe.cooktime(api.registered_shapes[shape].eighths),
			})
		end

	elseif recipe.type == "fuel" then
		local shapes = api.get_shapes(recipe.recipe)

		for _, shape in ipairs(shapes) do
			minetest.register_craft({
				type = "fuel",
				recipe = api.get_schema_recipe_item(recipe.recipe, shape),
				burntime = recipe.burntime(api.registered_shapes[shape].eighths),
			})
		end

	else
		error(("unsupported recipe type %s"):format(recipe.type))
	end
end
