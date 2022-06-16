if not stairsplus.has.stairs then
	return
end

local api = stairsplus.api

local S = stairsplus.S

local default_align_style = stairsplus.settings.default_align_style
local is_legacy_drawtype = stairsplus.compat.is_legacy_drawtype

-- stairs compat: override what stairs does, and "fix" any stairs which were already registered...

function stairs.register_stair(subname, node, groups, tiles, description, sounds, worldaligntex)
	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}
	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
	end

	api.register_single(node, "stair", {
		groups = groups,
		tiles = tiles,
		description = description,
		sounds = sounds,
	}, meta)

	minetest.register_alias(("stairs:stair_%s"):format(subname), api.format_name(node, "stair"))
end

function stairs.register_slab(subname, node, groups, images, description, sounds, worldaligntex)
	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}
	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
	end

	api.register_single(node, "slab_8", {
		groups = groups,
		tiles = images,
		description = description,
		sounds = sounds,
	}, meta)

	minetest.register_alias(("stairs:slab_%s"):format(subname), api.format_name(node, "slab_8"))
end

function stairs.register_stair_inner(subname, node, groups, tiles, description, sounds, worldaligntex, full_description)
	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}
	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
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
	local meta = {
		align_style = worldaligntex and "world" or default_align_style
	}
	if is_legacy_drawtype(node) then
		meta.ignore_drawtype = true
	end

	api.register_single(node, "stair_outer", {
		groups = groups,
		tiles = tiles,
		description = full_description or S("Inner @1", description),
		sounds = sounds,
	}, meta)

	minetest.register_alias(("stairs:stair_outer_%s"):format(subname), api.format_name(node, "stair_outer"))
end
