-- luacheck: globals minetest

local creative_priv = invsaw.settings.creative_priv
local priv = invsaw.settings.priv

local function on_priv_change(name)
	local player = minetest.get_player_by_name(name)
	if player then
		invsaw.check_use_status(player)
	end
end

if minetest.registered_privileges[priv] then
	local def = minetest.registered_privileges[priv]
	local old_on_grant = def.on_grant
	local old_on_revoke = def.on_revoke
	def.on_grant = function(name, cause)
		on_priv_change(name)
		if old_on_grant then
			old_on_grant(name, cause)
		end
	end
	def.on_revoke = function(name, cause)
		on_priv_change(name)
		if old_on_revoke then
			old_on_revoke(name, cause)
		end
	end
else
	minetest.register_privilege(priv, {
		description = "Allow use of the circular saw in inventory",
		give_to_singleplayer = true,
		give_to_admin = false,
		on_grant = on_priv_change,
		on_revoke = on_priv_change,
	})
end

if minetest.registered_privileges[creative_priv] then
	local def = minetest.registered_privileges[creative_priv]
	local old_on_grant = def.on_grant
	local old_on_revoke = def.on_revoke
	def.on_grant = function(name, cause)
		on_priv_change(name)
		if old_on_grant then
			old_on_grant(name, cause)
		end
	end
	def.on_revoke = function(name, cause)
		on_priv_change(name)
		if old_on_revoke then
			old_on_revoke(name, cause)
		end
	end
else
	minetest.register_privilege(creative_priv, {
		description = "Allow use of the inventory saw creatively",
		give_to_singleplayer = true,
		give_to_admin = false,
		on_grant = on_priv_change,
		on_revoke = on_priv_change,
	})
end
