-- for registering variants of a specific node
--[[

]]
local api = stairsplus.api

local table_set_all = stairsplus.util.table_set_all
local table_sort_keys = stairsplus.util.table_sort_keys

local S = stairsplus.S

local legacy_mode = stairsplus.settings.legacy_mode
local legacy_place_mechanic = stairsplus.settings.legacy_place_mechanic
local default_align_style = stairsplus.settings.default_align_style

api.nodes_by_shape = {}
api.shapes_by_node = {}

local function scale_light(light_source, shape_def)
	if not light_source or light_source == 0 then
		return 0
	elseif legacy_mode then
		return light_source - 1
	end

	return math.max(1, math.min(math.round(light_source * shape_def.eighths / 4), light_source))
end

local function check_node_validity(node_def, meta)
	local type_ = node_def.type
	if not meta.ignore_type and type_ ~= "node" then
		error(("cannot register non-node %q w/ stairsplus"):format(node_def.name))
	end

	local drawtype = node_def.drawtype
	if not meta.ignore_drawtype and (
		drawtype == "airlike" or
		drawtype == "liquid" or
		drawtype == "flowingliquid" or
		drawtype == "torchlike" or
		drawtype == "signlike" or
		drawtype == "plantlike" or
		drawtype == "firelike" or
		drawtype == "fencelike" or
		drawtype == "raillike" or
		drawtype == "nodebox" or
		drawtype == "mesh" or
		drawtype == "plantlike_rooted"
	) then
		error(("cannot register %q w/ drawtype %q w/ stairsplus"):format(node_def.name, drawtype))
	end

	local paramtype2 = node_def.paramtype2
	if not meta.ignore_paramtype2 and (
		paramtype2 == "flowingliquid" or
		paramtype2 == "wallmounted" or
		paramtype2 == "leveled" or
		paramtype2 == "degrotate" or
		paramtype2 == "meshoptions" or
		paramtype2 == "color" or
		paramtype2 == "colorwallmounted" or
		paramtype2 == "glasslikeliquidlevel" or
		paramtype2 == "colordegrotate"
	) then
		error(("cannot register %q w/ paramtype2 %q w/ stairsplus"):format(node_def.name, paramtype2))
	end
end

local wall_right_dirmap = {9, 18, 7, 12}
local wall_left_dirmap = {11, 16, 5, 14}
local ceil_dirmap = {20, 23, 22, 21}

function api.legacy_on_place(itemstack, placer, pointed_thing)
	if not minetest.is_player(placer) then
		return minetest.item_place(itemstack, placer, pointed_thing)
	end

	local controls = placer:get_player_control()

	local sneak = controls.sneak
	local aux = controls.aux1

	local shaped_node_name = itemstack:get_name()
	local shape = api.get_shape_of_shaped_node(shaped_node_name)

	local under = pointed_thing.under
	local under_node = minetest.get_node(under)
	local under_shape = api.get_shape_of_shaped_node(under_node.name)

	local same_cat = shape == under_shape

	-- standard (floor) facedir, also used for sneak placement against the lower half of the wall
	local p2 = placer and minetest.dir_to_facedir(placer:get_look_dir()) or 0

	-- check which face and which quadrant we are interested in
	-- this is used both to check if we're handling parallel placement in the same-category case,
	-- and in general for sneak placement
	local face_pos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
	local face_off = vector.subtract(face_pos, under)

	-- we cannot trust face_off to tell us the correct directionif the
	-- under node has a non-standard shape, so use the distance between under and above
	local wallmounted = minetest.dir_to_wallmounted(vector.subtract(pointed_thing.above, under))

	if same_cat and not aux then
		p2 = under_node.param2
		-- flip if placing above or below an upright or upside-down node
		-- TODO should we also flip when placing next to a side-mounted node?
		if wallmounted < 2 then
			if p2 < 4 then
				p2 = (p2 + 2) % 4
				p2 = ceil_dirmap[p2 + 1]
			elseif p2 > 19 then
				p2 = ceil_dirmap[p2 - 19] - 20
				p2 = (p2 + 2) % 4
			end
		end
	else
		-- for same-cat placement, aux is used to disable param2 copying
		if same_cat then
			aux = not aux
		end

		local remap = nil

		-- standard placement against the wall
		local use_wallmap = (wallmounted > 1 and not sneak) or (wallmounted < 2 and sneak)

		-- standard placement against the ceiling, or sneak placement against the upper half of the wall
		local use_ceilmap = wallmounted == 1 and not sneak
		use_ceilmap = use_ceilmap or (wallmounted > 1 and sneak and face_off.y > 0)

		if use_wallmap then
			local left = (p2 == 0 and face_off.x < 0) or
				(p2 == 1 and face_off.z > 0) or
				(p2 == 2 and face_off.x > 0) or
				(p2 == 3 and face_off.z < 0)
			if aux then
				left = not left
			end
			remap = left and wall_left_dirmap or wall_right_dirmap
		elseif use_ceilmap then
			remap = ceil_dirmap
		end

		if aux then
			p2 = (p2 + 2) % 4
		end

		if remap then
			p2 = remap[p2 + 1]
		end
	end

	return minetest.item_place(itemstack, placer, pointed_thing, p2)
end

function api.format_name(node, shape)
	local mod, name = node:match("^([^:]+):(.*)$")
	local shape_def = api.registered_shapes[shape]
	return ("%s:%s"):format(mod, shape_def.name_format:format(name))
end

function api.register_single(node, shape, overrides, meta)
	stairsplus.log("info", "registering %s %s", shape, node)
	meta = meta or {}
	overrides = overrides or {}
	if not minetest.registered_nodes[node] then
		error(("%q is not defined"):format(node))
	end
	local node_def = table.copy(minetest.registered_nodes[node])
	check_node_validity(node_def, meta)

	if shape ~= "micro_8" and not (api.nodes_by_shape.micro_8 or {})[node] then
		-- always make sure a microblock exists
		api.register_single(node, "micro_8", overrides, meta)
	end

	if (api.nodes_by_shape[shape] or {})[node] then
		return -- already registered
	end

	local shape_def = api.registered_shapes[shape]

	local paramtype2
	if node_def.paramtype2 == "colorfacedir" then
		paramtype2 = "colorfacedir"
	else
		paramtype2 = shape_def.paramtype2 or "facedir"
	end

	-- shaped_node definition
	local def = {
		description = S(shape_def.description, node_def.description or node),

		drawtype = shape_def.drawtype,
		mesh = shape_def.mesh,
		node_box = shape_def.node_box,
		collision_box = shape_def.collision_box,
		selection_box = shape_def.selection_box,
		paramtype = shape_def.paramtype or "light",
		paramtype2 = paramtype2,

		light_source = scale_light(node_def.light_source, shape_def),
		groups = api.build_groups(node, shape),

		tiles = node_def.tiles,
		overlay_tiles = node_def.overlay_tiles,
		use_texture_alpha = node_def.use_texture_alpha,
		color = node_def.color,
		palette = node_def.palette,  -- for coloredfacedir
		stack_max = node_def.stack_max,
		sound = node_def.sound,
		is_ground_content = node_def.is_ground_content,
		walkable = node_def.walkable,
		pointable = node_def.pointable,
		diggable = node_def.diggable,
		climbable = node_def.climbable,
		move_resistance = node_def.move_resistance,
	}

	-- see-through nodes tend to look better if we just use the first tile
	if (node_def.drawtype or ""):match("glass") then
		if #def.tiles > 1 then
			def.tiles = {def.tiles[1]}
		end

		if def.overlay_tiles and #def.overlay_tiles > 1 then
			def.overlay_tiles = {def.overlay_tiles[1]}
		end
	end

	if node_def.short_description then
		def.short_description = S(shape_def.description, node_def.short_description)
	end

	-- if there's a drop defined, and we can drop a shaped version, do so
	if node_def.drop and type(node_def.drop) == "string" then
		local item = api.get_shaped_node(node_def.drop, shape)
		if item then
			def.drop = item
		end
	end

	if legacy_place_mechanic then
		def.on_place = api.legacy_on_place
	end

	overrides.groups = nil
	table_set_all(def, overrides)

	-- set backface_culling and align_style
	local align_style = meta.align_style or default_align_style
	for i, tile in ipairs(def.tiles) do
		if type(tile) == "string" then
			def.tiles[i] = {
				name = tile,
				backface_culling = true,
				align_style = align_style,
			}
		elseif not (tile.animation or tile.color) then
			tile.backface_culling = true
			tile.align_style = align_style
		end
	end

	if def.overlay_tiles then
		for i, tile in ipairs(def.overlay_tiles) do
			if type(tile) == "string" then
				def.tiles[i] = {
					name = tile,
					backface_culling = true,
					align_style = align_style,
				}
			elseif not (tile.animation or tile.color) then
				tile.backface_culling = true
				tile.align_style = align_style
			end
			def.overlay_tiles[i] = tile
		end
	end

	-- register node
	local shaped_name = api.format_name(node, shape)
	minetest.register_node(":" .. shaped_name, def)

	-- alias old name formats
	if shape_def.aliases then
		local mod, name = node:match("^([^:]+):(.*)$")
		for _, alias in ipairs(shape_def.aliases) do
			minetest.register_alias(
				("%s:%s"):format(mod, alias:format(name)),
				shaped_name
			)
		end
	end

	local nodes = api.nodes_by_shape[shape] or {}
	nodes[node] = true
	api.nodes_by_shape[shape] = nodes

	local shapes = api.shapes_by_node[node] or {}
	shapes[shape] = true
	api.shapes_by_node[node] = shapes

	return shaped_name
end

function api.register_all(node, overrides, meta)
	for shape in pairs(api.registered_shapes) do
		api.register_single(node, shape, overrides, meta)
	end
end

function api.register_custom(node, list, overrides, meta)
	for _, shape in ipairs(list) do
		api.register_single(node, shape, overrides, meta)
	end
end

function api.register_group(node, group, overrides, meta)
	for _, shape in ipairs(api.shapes_by_group[group] or {}) do
		api.register_single(node, shape, overrides, meta)
	end
end

function api.register_groups(node, groups, overrides, meta)
	for _, group in ipairs(groups) do
		api.register_group(node, group, overrides, meta)
	end
end

function api.get_shapes(node)
	return table_sort_keys(api.shapes_by_node[node])
end

-- warning: don't mutate the return value
function api.get_shapes_hash(node)
	return api.shapes_by_node[node]
end

function api.get_shaped_node(node, shape_or_item)
	if shape_or_item == "" then
		return ""
	end

	local name, count = shape_or_item:match("^([^ ]+) (%d+)")

	if not name then
		name = shape_or_item
	end

	count = tonumber(count)

	if api.registered_shapes[name] then
		name = api.format_name(node, name)

	elseif name == "node" then
		name = node
	end

	if count then
		return ("%s %s"):format(name, count)
	else
		return name
	end
end

function api.get_micronode(node)
	return api.format_name(node, "micro_8")
end

api.node_by_shaped_node = {}
api.shape_by_shaped_node = {}

function api.get_node_of_shaped_node(shaped_node)
	return api.node_by_shaped_node[shaped_node]
end

function api.get_shape_of_shaped_node(shaped_node)
	return api.shape_by_shaped_node[shaped_node]
end

minetest.register_on_mods_loaded(function()
	stairsplus.log("info", "registering schema crafts")
	for node, shapes in pairs(api.shapes_by_node) do
		for shape in pairs(shapes) do
			local shaped_node = api.format_name(node, shape)
			api.node_by_shaped_node[shaped_node] = node
			api.shape_by_shaped_node[shaped_node] = shape
		end

		api.node_by_shaped_node[node] = node
		api.shape_by_shaped_node[node] = "node"

		api.register_schema_crafts_for_node(node)
	end
end)
