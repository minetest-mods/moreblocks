moreblocks.config = {}

local function getbool_default(setting, default)
	local value = minetest.setting_getbool(setting)
	if value == nil then
		value = default
	end
	return value
end

local function setting(settingtype, name, default)
	if settingtype == "bool" then
		moreblocks.config[name] =
			getbool_default("moreblocks." .. name, default)
	else
		moreblocks.config[name] =
			minetest.setting_get("moreblocks." .. name) or default
	end
end

-- Whether to direct wood based on player yaw when placing the block (true or false).
setting("bool", "wood_facedir", true)

-- Allow stair/slab crafting without a circular saw or not (true or false).
setting("bool", "allow_stair_slab_crafting", false)

-- Show stairs/slabs/panels/microblocks in creative inventory (true or false).
setting("bool", "show_stairsplus_creative_inv", false)
