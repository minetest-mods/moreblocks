# API documentation for Stairs+

In general, function arguments specified in square brackets ("[ ]") are optional.

## Shape API

For registering new shapes.

* `stairsplus.api.register_shape(name, def)`
  An example of a node_box shape:
  ```lua
  stairsplus.api.register_shape("slab_8", {
    name_format = "slab_%s_8",
    aliases = {"slab_%s"},
    description = "@1 1/2 Slab",
    shape_groups = {slab = 1, legacy = 1},
    eighths = 4,
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
  })
  ```
  An example of a mesh shape:
  ```lua
  local box_slope = {
    type = "fixed",
    fixed = {
      {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
      {-0.5, -0.25, -0.25, 0.5, 0, 0.5},
      {-0.5, 0, 0, 0.5, 0.25, 0.5},
      {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}
    }
  }

  stairsplus.api.register_shape("slope", {
    name_format = "slope_%s",
    description = "@1 Slope",
    shape_groups = {slope = 1, legacy = 1},
    eighths = 4,
    drawtype = "mesh",
    mesh = "stairsplus_slope.obj",
    collision_box = box_slope,
    selection_box = box_slope,
  })
  ```
  Hopefully most of the paramaters should be self explanatory. `eighths` is the number of 1/8th node
  microblocks that the shape is "worth", i.e. how much material is used in crafting it.
* `stairsplus.api.register_shape_group(shape_group, shapes)`
  Register a new shape group.

The following tables are exposed for convenience, but shouldn't be directly modified:

* `stairsplus.api.registered_shapes`
  A hash of shape definitions by name.

* `stairsplus.api.shapes_by_group`
  A hash of lists of shapes in a group, by the shape group name.


## Node API

These are for registering shapes of a node

* `stairsplus.api.register_on_register_single(function(node, shaped_name))`
  Register a callback for when a shaped node is registered. Mostly useful for integration with
  inventory managers.

* `stairsplus.api.register_single(node, shape, [overrides], [meta])`
  Register a single shape of a node.
  If no "micro_8" shape is defined, it will be defined before registering another shape. Attempting to
  register an already-registered shape will not override anything.
  Many of the node's properties will be inherited from the
  node and shape definition, but can be manually changed via `overrides`. `meta` is used to specify
  whether special logic should be used while defining the shaped node. The following values are supported:
  * `ignore_type = true`
    Whether to ignore the base node's `type` - usually, it is an error to try to register a shape for a
    non-node.
  * `ignore_drawtype = true`
    Whether to ignore the base node's `drawtye`. Usually, it is an error to try to register a shape for a
    non-node-like drawtype.
  * `ignore_paramtype2 = true`
    Whether to ignore the base node's `paramtype2`. Usually, it is an error to register a shape for node
    which is not compatible with a `facedir` drawtype.
  * `align_style = "node" | "user" | "world"`
    Whether to override the align_style for the textures used to draw the shaped node. The default behavior
    is to use the value defined by the `stairsplus.default_align_style` setting, which defaults to `"user"`.
  * `allow_override_groups = true`
    Whether to allow groups to be specified in the overrides (otherwise, they are ignored).
  * `allow_override_drawtype = true`
    Whether to allow a drawtype to be specified in the overrides (otherwise, it is ignored).
  * `allow_override_paramtype2 = true`
    Whether to allow a paramtype2 to be specified in the overrides (otherwise, it is ignored).

* `stairsplus.api.register_all(node, [overrides], [meta])`
  Register all registered shapes for a node. we do not recommend using this, due to the 32767 node limit.
  we recommend using

* `stairsplus.api.register_shapes(node, shapes, [overrides], [meta])`
  Register variants for a custom list of shapes.
* `stairsplus.api.register_group(node, shape_group, [overrides], [meta])`
  Register variants for a defined shape group.
* `stairsplus.api.register_groups(node, shape_groups, [overrides], [meta])`
  Register variants for a list of shape groups.

* `stairsplus.api.format_name(node, shape)`
  Get the itemstring for a shaped variant. It is not guaranteed that the resulting itemstring actually
  exists.

* `stairsplus.api.get_shapes(node)`
  Get the defined shapes for a node. Returns `nil` if no shapes are registered for the node.

* `stairsplus.api.get_shapes_hash(node)`
  Get a hash where the keys are the shapes supported by the node. Mutating the return value is not
  recommended. Will return `nil` if no shapes are registered for the node.

* `stairsplus.api.get_schema_recipe_item(node, shape_or_item)`
  If `shape_or_item` is an empty string, return an empty string. If it is an itemstring (contains a ":"),
  that itemstring is returned. If it is a shape, and the shape is defined for the given node, returns
  the name of the shaped node. If it is a shape, but the shape is not defined for the given node, returns
  `nil`. If it is the special string `"node"`, then it returns the node argument. `shape_or_item` may
  optionally specify a count value, which will modify the returned value accordingly.
  ```lua
  assert(stairsplus.api.get_schema_recipe_item("default:stone", "node 3") == "default:stone 3")
  assert(stairsplus.api.get_schema_recipe_item("default:stone", "slope 3") == "default:slope_stone 3")
  ```

* `stairsplus.api.get_micronode(node)`
  Convenience method for `stairsplus.api.get_schema_recipe_item(node, "micro_8")`.

* `stairsplus.api.get_node_of_shaped_node(shaped_node)`
  Given a shaped node, get the "base" node it was made from.

* `stairsplus.api.get_shape_of_shaped_node(shaped_node)`
  Given a shaped node, get its shape.


## Alias API

* `stairsplus.api.register_alias_single(old_node, new_node, shape)`
  Hopefully this is self-explanatory.
* `stairsplus.api.register_alias_all(old_node, new_node)`
* `stairsplus.api.register_alias_shapes(old_node, new_node, shapes)`
* `stairsplus.api.register_alias_group(old_node, new_node, group)`
* `stairsplus.api.register_alias_groups(old_node, new_node, groups)`

* `stairsplus.api.register_alias_force_single(old_node, new_node, shape)`
  `alias_force` implies that the shapes for the "old_node" already exist, so after aliasing them,
  we remove them from internal data structures.
* `stairsplus.api.register_alias_force_all(old_node, new_node)`
* `stairsplus.api.register_alias_force_shapes(old_node, new_node, shape)`
* `stairsplus.api.register_alias_force_group(old_node, new_node, group)`
* `stairsplus.api.register_alias_force_groups(old_node, new_node, groups)`

## Group API

Specify how to handle a node's groups when creating a shaped variant. By default, a node's
groups have their name transformed in the same way that the node's name is, e.g. `"wood"` will become e.g.
`"micro_wood_8"`, so that the shaped nodes can't be used in crafting recipes that call for `"group:wood"`.

* `stairsplus.api.register_passthrough_group(group)`
  Mark a group as "passthrough", i.e. it will not be transformed when assigned to a shaped node.
  This is necessary to e.g. allow nodes to dig-able (e.g. groups like `"cracky"`, `"oddly_breakable_by_hand"`).

* `stairsplus.api.register_passthrough_groups(groups)`
  Marks a list of groups as passthrough.

* `stairsplus.api.register_scaling_group(group)`
  Like "passthrough", but this scales the group's *value* depending on the # of "eighths" that the shape
  is worth. This is useful for groups like `"fall_damage_add_percent"` and `"slippery"`.

* `stairsplus.api.register_scaling_groups(groups)`
  Marks a list of groups as scaling.

* `stairsplus.api.register_ignore_group(group)`
  Marks a group as something we should just ignore entirely when creating a shaped node. Useful
  for things like `"connect_to_raillike"` or `"attached_node"`, which don't makde sense for a shaped
  node.

* `stairsplus.api.register_ignore_groups(groups)`
  Marks a list of groups to ignore.

* `stairsplus.api.build_groups(node, shape)`
  Given a node and a shape, return the groups to assign to a shaped node.

## Legacy API

These are methods that support legacy behavior which can optionally be disabled.

* `stairsplus.api.on_place(itemstack, placer, pointed_thing)`
  Handle placing a node. The legacy behavior is to try to rotate the node based on a number of
  obscure factors. It can be useful sometimes, but confusing other times.

* `stairsplus.api.scale_light(light_source, shape_def)`
  How much light should a shaped glowing node emit? The legacy behavior was to drop the value by `1`.
  The non-legacy behavior scales it down more, based on the number of eighths used in the shape.

## Crafting API

A powerful new API for registering crafting recipes involving shaped nodes.

* `stairsplus.api.register_on_register_craft_schema(func)`
  A callback for when a schema is registered. Useful for integrating inventory managers.

* `stairsplus.api.register_craft_schema(schema)`
  Register a crafting schema, which is like a normal crafting recipe, but it may have bare "shapes" in the
  recipe/output. For every node w/ the variants in the recipe, a variant involving those shaped nodes
  will be created (when all mods are loaded, so you don't have to worry about the order in which things
  are defined).
  ```lua
  stairsplus.api.register_craft_schema({
    output = "panel_8 6",
    recipe = {{"node", "node", "node"}},
  })

  stairsplus.api.register_craft_schema({
    type = "shapeless",
    output = "micro_8 7",
    recipe = {"stair_inner"},
  })
  ```

* `stairsplus.api.register_schema_crafts_for_node(node)`
  Creates real recipes for all schemas using available variants of the given node. Called automatically after all
  mods are loaded for every node which has shaped nodes. Currently only supports "shaped" and "shapeless" recipe
  types (these don't make much sense for cooking/fuel). Given the schemas above, if called for `"default:stone"`,
  this would result in the following:
  ```lua
  minetest.register_craft({
    output = "default:panel_stone_8 6",
    recipe = {{"default:stone", "default:stone", "default:stone"}},
  })

  minetest.register_craft({
    type = "shapeless",
    output = "default:micro_stone_8 7",
    recipe = {"default:stair_stone_inner"},
  })
  ```

* `stairsplus.api.register_crafts_for_shapes(recipe)`
  For "cooking" and "fuel" recipe types, register scaled variants for all *currently defined*
  shaped variants. It is an error to try to register a cooking recipe for nodes with mis-matched shapes.
  ```lua
  stairsplus.api.register_crafts_for_shapes({
    type = "cooking",
    output = "default:stone",
    recipe = "default:cobblestone",
    cooktime = 3,
  })

  stairsplus.api.register_crafts_for_shapes({
    type = "fuel",
    recipe = "default:coalblock",
    burntime = 370,
  })
  ```
  which would result in concrete recipes like
  ```lua
  minetest.register_craft({
    type = "cooking",
    output = "default:panel_stone_8",
    recipe = "default:panel_cobblestone_8",
    cooktime = 0.75,
  })

  minetest.register_craft({
    type = "fuel",
    recipe = "default:panel_coalblock_8",
    burntime = 92.5,
  })
  ```

## Station API

For the creation of crafting stations which can be used to transform nodes into shaped variants, and back.

* `stairsplus.api.register_station(name, def)`
  * `name`: an itemstring
  * `def`: a regular node definition, with the following parameters:
    * `shape_groups`: a list of shape groups that can be created with the station (required).
    * `build_formspec = function(meta, inv)`
      A function which will build the formspec for the node (not required, but you probably want to use it).
    * `update_metadata = function(meta, inv)`
      A function which updates the node's metadata (optional)

## Compat API

For compatability w/ other mods

* `function stairsplus.compat.override_stairs(name, node, overrides, meta)`
  Override stairs registered w/ the `stairs` mod, and replace them w/ stairsplus-compatible nodes.

# Legacy API

Methods from the previous "moreblocks" version of stairsplus which are still provided so as not to break
compatability with older mods.

* `stairsplus:register_all(modname, subname, recipeitem, fields)`
  Example:
  ```lua
  stairsplus:register_all("moreblocks", "wood", "default:wood", {
    description = "Wooden",
    tiles = {"default_wood.png"},
    groups = {oddly_breakabe_by_hand=1},
    sounds = moreblocks.node_sound_wood_defaults(),
  })
  ```
* `stairsplus:register_micro(modname, subname, recipeitem, fields)`
* `stairsplus:register_panel(modname, subname, recipeitem, fields)`
* `stairsplus:register_slab(modname, subname, recipeitem, fields)`
* `stairsplus:register_slope(modname, subname, recipeitem, fields)`
* `stairsplus:register_stair(modname, subname, recipeitem, fields)`
* `stairsplus:register_custom_subset(subset, modname, subname, recipeitem, fields)`

* `stairsplus:register_alias_all(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_micro(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_panel(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_slab(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_slope(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_stair(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_custom_subset_alias(subset, modname_old, subname_old, modname_new, subname_new)`

* `stairsplus:register_alias_force_all(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_force_micro(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_force_panel(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_force_slab(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_force_slope(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_alias_force_stair(modname_old, subname_old, modname_new, subname_new)`
* `stairsplus:register_custom_subset_alias(subset, modname_old, subname_old, modname_new, subname_new)`
