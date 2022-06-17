# API documentation for Stairs+

TODO: write new API docs


api.register_craft_schema({
	output = "panel_8 6",
	recipe = {{"node", "node", "node"}},
})

api.register_craft_schema({
	type = "shapeless",
	output = "micro_8 7",
	recipe = {"stair_inner"},
})

api.register_schema_crafts_for_node("default:coalblock")

api.register_crafts_for_shapes({
	type = "cooking",
	output = "default:stone",
	recipe = "default:cobblestone",
	cooktime = function(eights) return 3 * eights / 8 end,
})

api.register_crafts_for_shapes({
	type = "fuel",
	recipe = "default:coalblock",
	burntime = function(eights) return 370 * eights / 8 end,
})

# legacy API

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
    sounds = moreblocks.node_sound_wood_defaults(),
  })
  ```

need to also support legacy aliasing
