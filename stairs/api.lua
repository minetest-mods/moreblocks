local f = string.format

local api = stairsplus.api

local S = stairsplus.S

local legacy = stairs.legacy

local is_legacy_drawtype = stairsplus.compat.is_legacy_drawtype
local is_legacy_paramtype2 = stairsplus.compat.is_legacy_paramtype2

local default_align_style = stairsplus.settings.default_align_style
local legacy_stairs_without_recipeitem = stairs.settings.legacy_stairs_without_recipeitem

function stairs.register_stair(subname, node, groups, tiles, description, sounds, worldaligntex)
	if not minetest.registered_nodes[node] then
		-- registering a stair for a node that doesn't exist
		if legacy_stairs_without_recipeitem then
			legacy.register_stair(subname, node, groups, tiles, description, sounds, worldaligntex)
			return

		else
			error(f("attempt to register stairs for unknown node %q. " ..
				"set `stairs.legacy_stairs_without_recipeitem = true` in minetest.conf to enable this behavior.", node))
		end
	end

	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}

	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
	end
	if is_legacy_paramtype2(node) then
		meta.ignore_paramtype2 = true
	end

	api.register_single(node, "stair", {
		groups = groups,
		tiles = tiles,
		description = description,
		sounds = sounds,
	}, meta)

	minetest.register_alias(("stairs:stair_%s"):format(subname), api.format_name(node, "stair"))
end

function stairs.register_slab(subname, node, groups, tiles, description, sounds, worldaligntex)
	if not minetest.registered_nodes[node] then
		-- registering a stair for a node that doesn't exist
		if legacy_stairs_without_recipeitem then
			legacy.register_slab(subname, node, groups, tiles, description, sounds, worldaligntex)
			return

		else
			error(f("attempt to register stairs for unknown node %q. " ..
				"set `stairs.legacy_stairs_without_recipeitem = true` in minetest.conf to enable this behavior.", node))
		end
	end

	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}
	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
	end
	if is_legacy_paramtype2(node) then
		meta.ignore_paramtype2 = true
	end

	api.register_single(node, "slab_8", {
		groups = groups,
		tiles = tiles,
		description = description,
		sounds = sounds,
	}, meta)

	minetest.register_alias(("stairs:slab_%s"):format(subname), api.format_name(node, "slab_8"))
end

function stairs.register_stair_inner(subname, node, groups, tiles, description, sounds, worldaligntex, full_description)
	if not minetest.registered_nodes[node] then
		-- registering a stair for a node that doesn't exist
		if legacy_stairs_without_recipeitem then
			legacy.register_stair_inner(subname, node, groups, tiles, description, sounds, worldaligntex,
				full_description)
			return

		else
			error(f("attempt to register stairs for unknown node %q. " ..
				"set `stairs.legacy_stairs_without_recipeitem = true` in minetest.conf to enable this behavior.", node))
		end
	end

	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}
	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
	end
	if is_legacy_paramtype2(node) then
		meta.ignore_paramtype2 = true
	end

	api.register_single(node, "stair_inner", {
		groups = groups,
		tiles = tiles,
		description = full_description or S("Inner @1", description),
		sounds = sounds,
	}, meta)

	minetest.register_alias(("stairs:stair_inner_%s"):format(subname), api.format_name(node, "stair_inner"))
end

function stairs.register_stair_outer(subname, node, groups, tiles, description, sounds, worldaligntex, full_description)
	if not minetest.registered_nodes[node] then
		-- registering a stair for a node that doesn't exist
		if legacy_stairs_without_recipeitem then
			legacy.register_stair_outer(subname, node, groups, tiles, description, sounds, worldaligntex,
				full_description)
			return

		else
			error(f("attempt to register stairs for unknown node %q. " ..
				"set `stairs.legacy_stairs_without_recipeitem = true` in minetest.conf to enable this behavior.", node))
		end
	end

	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}
	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
	end
	if is_legacy_paramtype2(node) then
		meta.ignore_paramtype2 = true
	end

	api.register_single(node, "stair_outer", {
		groups = groups,
		tiles = tiles,
		description = full_description or S("Outer @1", description),
		sounds = sounds,
	}, meta)

	minetest.register_alias(("stairs:stair_outer_%s"):format(subname), api.format_name(node, "stair_outer"))
end

function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab, sounds,
										worldaligntex, desc_stair_inner, desc_stair_outer)
        stairs.register_stair(subname, recipeitem, groups, images, desc_stair, sounds, worldaligntex)
        stairs.register_slab(subname, recipeitem, groups, images, desc_slab, sounds, worldaligntex)
        stairs.register_stair_inner(subname, recipeitem, groups, images, desc_stair, sounds, worldaligntex,
			desc_stair_inner)
        stairs.register_stair_outer(subname, recipeitem, groups, images, desc_stair, sounds, worldaligntex,
			desc_stair_outer)
end
