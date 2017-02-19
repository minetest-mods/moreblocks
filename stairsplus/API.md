# API documentation for Stairs+

* `stairsplus:register_all(modname, subname, recipeitem, fields)`
	Registers a stair, slab, panel, microblock, and any other types of
	nodes to be added in the future.
	This also registers the node with the circular saw.
	Example:
	```lua
	stairsplus:register_all("moreblocks", "wood", "defaut:wood", {
		description = "Wooden",
		tiles = {"default_wood.png"},
		groups = {oddly_breakabe_by_hand=1},
		sounds = default.node_sound_wood_defaults(),
	})
	```
The following register only a particular type of microblock.
You will probably never want to use them directly:

* `stairsplus:register_stair(modname, subname, recipeitem, fields)`
* `stairsplus:register_slab(modname, subname, recipeitem, fields)`
* `stairsplus:register_panel(modname, subname, recipeitem, fields)`
* `stairsplus:register_micro(modname, subname, recipeitem, fields)`

