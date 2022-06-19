local s = minetest.settings

invsaw.settings = {
	priv = s:get("invsaw.priv") or "interact",
	creative_priv =  s:get("invsaw.creative_priv") or "creative",
	saw_item = s:get("invsaw.saw_item") or "stairsplus:circular_saw"
}
