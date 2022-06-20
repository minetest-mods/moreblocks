-- luacheck: globals minetest

local creative_priv = invsaw.settings.creative_priv
local priv = invsaw.settings.priv

local function on_priv_change(name)
	local player = minetest.get_player_by_name(name)
	if player then
		invsaw.check_use_status(player)
	end
end

local function override_on_priv_change(old)
	return function(name, cause)
		on_priv_change(name)
		if old then
			old(name, cause)
		end
	end
end

if minetest.registered_privileges[priv] then
	local def = minetest.registered_privileges[priv]
	def.on_grant = override_on_priv_change(def.on_grant)
	def.on_revoke = override_on_priv_change(def.on_revoke)

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
	def.on_grant = override_on_priv_change(def.on_grant)
	def.on_revoke = override_on_priv_change(def.on_revoke)

else
	minetest.register_privilege(creative_priv, {
		description = "Allow use of the inventory saw creatively",
		give_to_singleplayer = true,
		give_to_admin = false,
		on_grant = on_priv_change,
		on_revoke = on_priv_change,
	})
end
