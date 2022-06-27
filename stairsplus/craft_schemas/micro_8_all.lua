local api = stairsplus.api
local register_craft_schema = api.register_craft_schema

for shape, shape_def in pairs(api.registered_shapes) do
	if shape ~= "micro_8" and math.floor(shape_def.eighths) > 0 then
		register_craft_schema({
			type = "shapeless",
			output = ("micro_8 %i"):format(shape_def.eighths),
			recipe = {shape},
		})
	end
end
