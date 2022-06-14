-- for registering recipe schemas
-- should register schemas w/ unified_inventory and i3 and whatever else,
-- and hide the recipes for the individual nodes (possibly a setting for such)
--[[

api.register_craft_schema({
	output = "panel_8 6",
	recipe = {{"node", "node", "node"}},
})

api.register_craft_schema({
	type = "shapeless",
	output = "micro_8 7",
	recipe = {"stair_inner"},
})

api.register_schema_crafts_for_node("default:coalblock")

api.register_crafts_for_shapes({
	type = "cooking",
	output = "default:stone",
	recipe = "default:cobblestone",
	cooktime = function(eights) return 3 * eights / 8 end,
})

api.register_crafts_for_shapes({
	type = "fuel",
	recipe = "default:coalblock",
	burntime = function(eights) return 370 * eights / 8 end,
})

]]
local api = stairsplus.api

local function is_valid_item(item, shapes)
	local item_name = ItemStack(item):get_name()

	return shapes[item_name] or item_name == "" or item_name:match(":")
end

local function verify_schema(schema)
	local problems = {}

	if not (schema.type == "shaped" or schema.type == "shapeless" or schema.type == nil) then
		table.insert(problems, ("unimplemented schema type %q"):format(schema.type))
	end

	if not is_valid_item(schema.output, api.registered_shapes) then
		table.insert(problems, ("don't know how to handle output %q"):format(schema.output))
	end

	if schema.replacements then
		for _, replacement in ipairs(schema.replacements) do
			for _, item in ipairs(replacement) do
				if not is_valid_item(schema.output, api.registered_shapes) then
					table.insert(problems, ("don't know how to handle replacement item %q"):format(item))
				end
			end
		end
	end

	if schema.type == "shapeless" then
		for _, item in ipairs(schema.recipe) do
			if not is_valid_item(schema.output, api.registered_shapes) then
				table.insert(problems, ("don't know how to handle craft item %q"):format(item))
			end
		end

	else
		for _, row in ipairs(schema.recipe) do
			for _, item in ipairs(row) do
				if not is_valid_item(schema.output, api.registered_shapes) then
					table.insert(problems, ("don't know how to handle craft item %q"):format(item))
				end
			end
		end
	end

	if #problems > 0 then
		return table.concat(problems, ", ")
	end
end

api.registered_recipe_schemas = {}
function api.register_craft_schema(schema)
	local problems = verify_schema(schema)

	if problems then
		error(problems)
	end

	table.insert(api.registered_recipe_schemas, schema)
end

local function has_the_right_shapes(schema, shapes)
	if not is_valid_item(schema.output, shapes) then
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

local function register_for_schema(node, shapes, schema)
	local recipe = table.copy(schema)

	if shapes[recipe.output] then
		recipe.output = api.get_shaped_node(node, recipe.output)
	end

	if recipe.replacements then
		for _, replacement in ipairs(recipe.replacements) do
			for i, item in ipairs(replacement) do
				if shapes[item] then
					replacement[i] = api.get_shaped_node(node, item)
				end
			end
		end
	end

	if recipe.type == "shapeless" then
		for i, item in ipairs(recipe.recipe) do
			if shapes[item] then
				recipe.recipe[i] = api.get_shaped_node(node, item)
			end
		end

	elseif recipe.type == "shaped" or recipe.type == nil then
		for _, row in ipairs(schema.recipe) do
			for i, item in ipairs(row) do
				if shapes[item] then
					row[i] = api.get_shaped_node(node, item)
				end
			end
		end
	end

	minetest.register_craft(recipe)
end

function api.register_schema_crafts_for_node(node)
	local shapes = api.get_shapes_hash(node)
	for _, schema in ipairs(api.registered_recipe_schemas) do
		if has_the_right_shapes(schema, shapes) then
			register_for_schema(node, shapes, schema)
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

function api.register_crafts_for_shapes(def)
	if def.type == "cooking" then
		assert(
			shapes_match(def.output, def.recipe),
			("error: shapes of %s and %s do not match"):format(def.output, def.recipe)
		)

		local shapes = api.get_shapes(def.recipe)

		for _, shape in ipairs(shapes) do
			minetest.register_craft({
				type = "cooking",
				output = api.get_shaped_node(def.output, shape),
				recipe = api.get_shaped_node(def.recipe, shape),
				cooktime = def.cooktime(api.registered_shapes[shape].eighths),
			})
		end

	elseif def.type == "fuel" then
		local shapes = api.get_shapes(def.recipe)

		for _, shape in ipairs(shapes) do
			minetest.register_craft({
				type = "fuel",
				recipe = api.get_shaped_node(def.recipe, shape),
				burntime = def.burntime(api.registered_shapes[shape].eighths),
			})
		end

	else
		error(("unsupported recipe type %s"):format(def.type))
	end
end
