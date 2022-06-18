local api = stairsplus.api

local legacy_mode = stairsplus.settings.legacy_mode
local legacy_place_mechanic = stairsplus.settings.legacy_place_mechanic

if legacy_place_mechanic then
	local wall_right_dirmap = {9, 18, 7, 12}
	local wall_left_dirmap = {11, 16, 5, 14}
	local ceil_dirmap = {20, 23, 22, 21}

	function api.on_place(itemstack, placer, pointed_thing)
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

else
	api.on_place = minetest.item_place
end

function api.scale_light(light_source, shape_def)
	if not light_source or light_source == 0 then
		return 0

	elseif legacy_mode then
		return light_source - 1
	end

	return math.max(1, math.min(math.round(light_source * shape_def.eighths / 4), light_source))
end
