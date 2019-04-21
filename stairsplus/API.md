# API documentation for Stairs+

* `stairsplus:register_all(modname, subname, recipeitem, fields)`
	Registers a stair, slab, panel, microblock, and any other types of
	nodes to be added in the future.
	This also registers the node with the circular saw.
	Example:
	```lua
	stairsplus:register_all("moreblocks", "wood", "default:wood", {
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
* `stairsplus:register_slope(modname, subname, recipeitem, fields)`

If you only want to register a subset of stairsplus nodes,
you can use the `stairsplus:register_custom_subset(subset, modname, subname, recipeitem, fields)` function.
The subset table should have the following format:

```lua
    local subset = {
    	{ "micro", "" },
    	{ "micro", "_1" },
    	{ "micro", "_2" },
    	{ "micro", "_4" },
    	{ "micro", "_12" },
    	{ "micro", "_14" },
    	{ "micro", "_15" },
    	{ "panel", "" },
    	{ "panel", "_1" },
    	{ "panel", "_2" },
    	{ "panel", "_4" },
    	{ "panel", "_12" },
    	{ "panel", "_14" },
    	{ "panel", "_15" },
    	{ "slab",  "" },
    	{ "slab",  "_quarter" },
    	{ "slab",  "_three_quarter" },
    	{ "slab",  "_1" },
    	{ "slab",  "_2" },
    	{ "slab",  "_14" },
    	{ "slab",  "_15" },
    	{ "slab",  "_two_sides" },
    	{ "slab",  "_three_sides" },
    	{ "slab",  "_three_sides_u" },
    	{ "slope", "" },
    	{ "slope", "_half" },
    	{ "slope", "_half_raised" },
    	{ "slope", "_inner" },
    	{ "slope", "_inner_half" },
    	{ "slope", "_inner_half_raised" },
    	{ "slope", "_inner_cut" },
    	{ "slope", "_inner_cut_half" },
    	{ "slope", "_inner_cut_half_raised" },
    	{ "slope", "_outer" },
    	{ "slope", "_outer_half" },
    	{ "slope", "_outer_half_raised" },
    	{ "slope", "_outer_cut" },
    	{ "slope", "_outer_cut_half" },
    	{ "slope", "_outer_cut_half_raised" },
    	{ "slope", "_cut" },
    	{ "stair", "" },
    	{ "stair", "_half" },
    	{ "stair", "_right_half" },
    	{ "stair", "_inner" },
    	{ "stair", "_outer" },
    	{ "stair", "_alt" },
    	{ "stair", "_alt_1" },
    	{ "stair", "_alt_2" },
    	{ "stair", "_alt_4" },
    }
```
You can remove entries as needed.
