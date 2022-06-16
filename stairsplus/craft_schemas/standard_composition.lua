local api = stairsplus.api
local register_craft_schema = api.register_craft_schema

local slices = {1, 2, 4, 8, 12, 14, 15}

local valid_slice = {
	[1] = true,
	[2] = true,
	[4] = true,
	[8] = true,
	[12] = true,
	[14] = true,
	[15] = true,
}

local promotion = {
	micro = "panel_8",
	panel = "slab_8",
	slab = "node",
}

local demotion = {
	node = "slab",
	slab = "panel",
	panel = "micro",
}

for _, shape in ipairs({"micro", "panel", "slab"}) do
	for _, slice1 in ipairs(slices) do
		local shape1 = ("%s_%s"):format(shape, slice1)
		local def1 = api.registered_shapes[shape1]

		for _, slice2 in ipairs(slices) do
			local shape2 = ("%s_%s"):format(shape, slice2)
			local def2 = api.registered_shapes[shape2]

			local slice3 = slice1 + slice2

			if valid_slice[slice3] then
				local shape3 = ("%s_%s"):format(shape, slice3)
				local def3 = api.registered_shapes[shape3]
				local n = math.floor((def1.eighths + def2.eighths) / def3.eighths)

				register_craft_schema({
					output = ("%s %s"):format(shape3, n),
					recipe = {
						{shape1},
						{shape2},
					},
				})

			elseif slice3 == 16 then
				register_craft_schema({
					output = ("%s"):format(promotion[shape]),
					recipe = {
						{shape1},
						{shape2},
					},
				})
			end
		end
	end
end

-- split in half horizontally

register_craft_schema({
	output = "slab_8 6",
	recipe = {{"node", "node", "node"}},
})

for _, shape in ipairs({"micro", "panel", "slab"}) do
	for _, slice1 in ipairs({2, 4, 8}) do
		local slice2 = slice1 / 2
		local shape1 = ("%s_%s"):format(shape, slice1)
		local shape2 = ("%s_%s"):format(shape, slice2)
		local def1 = api.registered_shapes[shape1]
		local def2 = api.registered_shapes[shape2]
		local n = math.floor(3 * def1.eighths / def2.eighths)

		register_craft_schema({
			output = ("%s %s"):format(shape2, n),
			recipe = {
				{shape1, shape1, shape1},
			},
		})
	end
end

-- split in half vertically

for _, shape in ipairs({"panel", "slab"}) do
	for _, slice in ipairs(slices) do
		local shape1 = ("%s_%s"):format(shape, slice)
		local shape2 = ("%s_%s"):format(demotion[shape], slice)
		local def1 = api.registered_shapes[shape1]
		local def2 = api.registered_shapes[shape2]
		local n = math.floor(3 * def1.eighths / def2.eighths)

		register_craft_schema({
			output = ("%s %s"):format(shape2, n),
			recipe = {
				{shape1},
				{shape1},
				{shape1},
			},
		})
	end
end
