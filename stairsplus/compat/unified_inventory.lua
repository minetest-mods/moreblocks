-- luacheck: read globals unified_inventory

if not stairsplus.has.unified_inventory then
	return
end

local api = stairsplus.api

unified_inventory.register_craft_type("stairsplus:circular_saw", {
	description = "Stairs+ circular saw",
	icon = "stairsplus_saw_button.png",
	width = 1,
	height = 1,
	uses_crafting_grid = false,
})

unified_inventory.register_category("stairsplus:cuttable", {
	symbol = "stairsplus:circular_saw",
	label = "Cuttable in the circular saw",
	index = 0,
	items = {}
})

unified_inventory.register_category("stairsplus:cut_node", {
	symbol = "stairsplus:circular_saw",
	label = "Nodes cut in the circular saw",
	index = 0,
	items = {}
})

local function on_register_single(node, shaped_name)
	unified_inventory.register_craft({
		output = shaped_name,
		type = "stairsplus:circular_saw",
		items = {node},
		width = 1,
	})

	unified_inventory.add_category_item("stairsplus:cuttable", node)
	unified_inventory.add_category_item("stairsplus:cut_node", shaped_name)
end

for _, single in ipairs(api.registered_singles) do
	local node, shaped_name = unpack(single)
	on_register_single(node, shaped_name)
end

api.register_on_register_single(on_register_single)
