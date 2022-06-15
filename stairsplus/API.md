# API documentation for Stairs+

TODO: write new API docs


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
