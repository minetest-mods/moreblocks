-- legacy: export old API for mods which depend on it
-- provide a configuration option to *disable* legacy. it must be enabled by default, to prevent breaking
-- existing servers
local api = stairsplus.api

local is_legacy_drawtype = stairsplus.compat.is_legacy_drawtype
local legacy_mode = stairsplus.settings.legacy_mode

local function clean_legacy_fields(fields)
	fields = fields or {}

	fields.drawtype = nil
	fields.light_source = nil
	fields.inventory_image = nil
	fields.inventory_overlay = nil
	fields.wield_image = nil
	fields.wield_overlay = nil
	fields.wield_scale = nil
	fields.tool_capabilities = nil
	fields.node_placement_prediction = nil
	fields.node_dig_prediction = nil
	fields.on_place = nil
	fields.on_secondary_use = nil
	fields.on_drop = nil
	fields.on_use = nil
	fields.after_use = nil
	fields.paramtype2 = nil
	fields.node_box = nil
	fields.mesh = nil
	fields.connects_to = nil
	fields.connect_sides = nil
	fields.selection_box = nil
	fields.collision_box = nil
	fields.legacy_facedir_simple = nil
	fields.legacy_wallmounted = nil
	if type(fields.drop) ~= "string" then
		fields.drop = nil
	end
	fields.on_construct = nil
	fields.on_destruct = nil
	fields.after_destruct = nil
	fields.after_place_node = nil
	fields.after_dig_node = nil
	fields.can_dig = nil
	fields.on_punch = nil
	fields.on_rightclick = nil
	fields.on_dig = nil
	fields.on_timer = nil
	fields.on_receive_fields = nil
	return fields
end

local function register_group(modname, subname, recipeitem, fields, group)
	fields = clean_legacy_fields(fields)
	local meta = {}
	if is_legacy_drawtype(recipeitem) then
		meta.ignore_drawtype = true
	end

	api.register_group(recipeitem, group, fields, meta)

	local old_name = ("%s:%s"):format(modname, subname)
	if old_name ~= recipeitem then
		api.register_alias_group(old_name, recipeitem, group)
	end
end

function stairsplus:register_all(modname, subname, recipeitem, fields)
	if legacy_mode then
		register_group(modname, subname, recipeitem, fields, "legacy")
	else
		register_group(modname, subname, recipeitem, fields, "common")
	end
end

function stairsplus:register_micro(modname, subname, recipeitem, fields)
	register_group(modname, subname, recipeitem, fields, "micro")
end

function stairsplus:register_panel(modname, subname, recipeitem, fields)
	register_group(modname, subname, recipeitem, fields, "panel")
end

function stairsplus:register_slab(modname, subname, recipeitem, fields)
	register_group(modname, subname, recipeitem, fields, "slab")
end

function stairsplus:register_slope(modname, subname, recipeitem, fields)
	register_group(modname, subname, recipeitem, fields, "slope")
end

function stairsplus:register_stair(modname, subname, recipeitem, fields)
	register_group(modname, subname, recipeitem, fields, "stair")
end

local fix_shape_table = {
	micro = "micro_8",
	panel = "panel_8",
	slab = "slab_8",
	slab_quarter = "slab_4",
	slab_three_quarter = "slab_12",
	stair_alt = "stair_alt_8",
}

local function interpret_subset(subset)
	local shapes = {}
	for _, v in ipairs(subset) do
		local shape = table.concat(v, "")
		shape = fix_shape_table[shape] or shape
		table.insert(shapes, shape)
	end
	return shapes
end

function stairsplus:register_custom_subset(subset, modname, subname, recipeitem, fields)
	local shapes = interpret_subset(subset)

	fields = clean_legacy_fields(fields)
	local meta = {}
	if is_legacy_drawtype(recipeitem) then
		meta.ignore_drawtype = true
	end

	api.register_singles(recipeitem, shapes, fields, meta)

	local old_name = ("%s:%s"):format(modname, subname)
	if old_name ~= recipeitem then
		api.register_alias_shapes(old_name, recipeitem, shapes)
	end
end

function stairsplus:register_alias_all(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)

	if legacy_mode then
		api.register_alias_group(old_node, new_node, "legacy")
	else
		api.register_alias_group(old_node, new_node, "common")
	end
end

function stairsplus:register_alias_micro(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_group(old_node, new_node, "micro")
end

function stairsplus:register_alias_panel(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_group(old_node, new_node, "panel")
end

function stairsplus:register_alias_slab(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_group(old_node, new_node, "slab")
end

function stairsplus:register_alias_slope(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_group(old_node, new_node, "slope")
end

function stairsplus:register_alias_stair(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_group(old_node, new_node, "stair")
end

function stairsplus:register_custom_subset_alias(subset, modname_old, subname_old, modname_new, subname_new)
	local shapes = interpret_subset(subset)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_shapes(old_node, new_node, shapes)
end

function stairsplus:register_alias_force_all(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)

	if legacy_mode then
		api.register_alias_force_group(old_node, new_node, "legacy")
	else
		api.register_alias_force_group(old_node, new_node, "common")
	end
end

function stairsplus:register_alias_force_micro(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_force_group(old_node, new_node, "micro")
end

function stairsplus:register_alias_force_panel(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_force_group(old_node, new_node, "panel")
end

function stairsplus:register_alias_force_slab(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_force_group(old_node, new_node, "slab")
end

function stairsplus:register_alias_force_slope(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_force_group(old_node, new_node, "slope")
end

function stairsplus:register_alias_force_stair(modname_old, subname_old, modname_new, subname_new)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_force_group(old_node, new_node, "stair")
end

function stairsplus:register_custom_subset_alias(subset, modname_old, subname_old, modname_new, subname_new)
	local shapes = interpret_subset(subset)
	local old_node = ("%s:%s"):format(modname_old, subname_old)
	local new_node = ("%s:%s"):format(modname_new, subname_new)
	api.register_alias_force_shapes(old_node, new_node, shapes)
end
