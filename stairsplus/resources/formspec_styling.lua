
stairsplus.resources.formspec_style = ""

if stairsplus.has.default then
	-- prepend background and slot styles from default if available
	stairsplus.resources.formspec_style = default.gui_bg .. default.gui_bg_img .. default.gui_slots
end
