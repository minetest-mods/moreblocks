local ui = unified_inventory

ui.register_button("saw", {
	type = "image",
	image = "stairsplus_saw_button.png",
	tooltip = "Circular Saw",
	condition = function(player)
		return invsaw.allow_use_saw(player)
	end,
})
