-- luacheck: globals i3

if not stairsplus.has.i3 then
	return
end

-- https://github.com/fluxionary/minetest-moreblocks/issues/13
-- remove i3's assumption that it controls our compression groups
for node in pairs(i3.compress_groups) do
	if node:match("^moreblocks:slope_") or node:match("^wool:slope_") then
		i3.compress_groups[node] = nil
	end
end

local api = stairsplus.api

i3.register_craft_type("stairsplus:circular_saw", {
	description = "Stairs+ circular saw",
	icon = "stairsplus_saw_button.png",
})

local function on_register_single(node, shaped_name)
	i3.register_craft({
		type = "stairsplus:circular_saw",
		result = shaped_name,
		items = {node},
	})

	local micronode = api.get_micronode(node)
	if shaped_name ~= micronode then
		local compress_groups = i3.compress_groups[micronode] or {}
		table.insert(compress_groups, shaped_name)
		i3.compress_groups[micronode] = compress_groups
		i3.compressed[shaped_name] = true
	end
end

for _, single in ipairs(api.registered_singles) do
	local node, shaped_name = unpack(single)
	on_register_single(node, shaped_name)
end

api.register_on_register_single(on_register_single)
