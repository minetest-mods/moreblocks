local cm = stairsplus.resources.craft_materials

if cm.steel_ingot then
	if moreblocks.settings.circular_saw_crafting then
		minetest.register_craft({
			output = "stairsplus:circular_saw",
			recipe = {
				{"", cm.steel_ingot, ""},
				{"group:wood", "group:wood", "group:wood"},
				{"group:wood", "", "group:wood"},
			}
		})
	end
end
