local ui = unified_inventory

ui.register_button("saw", {
	type = "image",
	image = "stairsplus_saw_button.png",
	tooltip = "Circular Saw",
	condition = function(player)
		return invsaw.allow_use_saw(player)
	end,
})

-- this takes over 3 seconds on my machine O_O
--local old_get_formspec = ui.get_formspec
--
--function ui.get_formspec(player, page)
--	local fs = old_get_formspec(player, page)
--	if invsaw.can_use_saw(player) then
--		return fs
--	end
--
--	local start = minetest.get_us_time()
--	-- excise the button
--	local pre, post = fs:match(
--		"(.*)image_button%[%-?%d+%.?%d*,%-?%d+%.?%d*;%-?%d+%.?%d*,%-?%d+%.?%d*;stairsplus_saw_button.png[^%]]*](.*)"
--	)
--
--	if not pre and post then
--		pre, post = fs:match(
--			"(.*)image%[%-?%d+%.?%d*,%-?%d+%.?%d*;%-?%d+%.?%d*,%-?%d+%.?%d*;stairsplus_saw_button.png[^%]]*](.*)"
--		)
--	end
--
--	if pre and post then
--		fs = pre .. post
--	end
--
--	minetest.chat_send_player(player:get_player_name(), ("took %s"):format((minetest.get_us_time() - start) / 1000000))
--
--	return fs
--end
