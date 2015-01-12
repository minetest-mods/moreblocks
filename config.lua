--[[
More Blocks: configuration handling

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

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

-- Show stairs/slabs/panels/microblocks in creative inventory (true or false):
setting("bool", "stairsplus_in_creative_inventory", false)
