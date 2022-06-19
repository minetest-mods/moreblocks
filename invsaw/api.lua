function invsaw.has_saw_in_inventory(player)
	local inv = player:get_inventory()
	return inv:contains_item("main", invsaw.settings.saw_item)
end

function invsaw.can_use_saw(player)
	return (
		minetest.check_player_privs(player, invsaw.settings.creative_priv) or
			minetest.check_player_privs(player, invsaw.settings.priv)
	)
end

function invsaw.allow_use_saw(player)
	return (
		minetest.check_player_privs(player, invsaw.settings.creative_priv) or
			(minetest.check_player_privs(player, invsaw.settings.priv) and invsaw.has_saw_in_inventory(player))
	)
end

function invsaw.check_use_status(player)
	if invsaw.can_use_saw(player) then
		invsaw.initialize_inventory(player)

	else
		invsaw.drop_inventory(player)
	end
end

minetest.register_on_joinplayer(invsaw.check_use_status)
