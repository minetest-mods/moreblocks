# API documentation for Stairs+

TODO: write new API docs

function stairsplus.api.register_alias_single(old_node, new_node, shape)
function stairsplus.api.register_alias_all(old_node, new_node)
function stairsplus.api.register_alias_custom(old_node, new_node, list)
function stairsplus.api.register_alias_group(old_node, new_node, group)
function stairsplus.api.register_alias_groups(old_node, new_node, groups)

function stairsplus.api.register_alias_force_single(old_node, new_node, shape)
function stairsplus.api.register_alias_force_all(old_node, new_node)
function stairsplus.api.register_alias_force_custom(old_node, new_node, list)
function stairsplus.api.register_alias_force_group(old_node, new_node, group)
function stairsplus.api.register_alias_force_groups(old_node, new_node, groups)


function stairsplus.api.register_passthrough_group(group)
function stairsplus.api.register_passthrough_groups(groups)
function stairsplus.api.register_scale_group(group)
function stairsplus.api.register_scale_groups(groups)
function stairsplus.api.register_ignore_group(group)
function stairsplus.api.register_ignore_groups(groups)

function stairsplus.api.build_groups(node, shape)

function stairsplus.api.on_place(itemstack, placer, pointed_thing)
function stairsplus.api.scale_light(light_source, shape_def)


function stairsplus.api.register_on_register_single(func)
function stairsplus.api.format_name(node, shape)
function stairsplus.api.register_single(node, shape, overrides, meta)
function stairsplus.api.register_all(node, overrides, meta)
function stairsplus.api.register_custom(node, list, overrides, meta)
function stairsplus.api.register_group(node, group, overrides, meta)
function stairsplus.api.register_groups(node, groups, overrides, meta)
function stairsplus.api.get_shapes(node)

-- warning: don't mutate the return value
function stairsplus.api.get_shapes_hash(node)

-- turn a recipe item into a shape if possible
function stairsplus.api.get_schema_recipe_item(node, shape_or_item)
function stairsplus.api.get_micronode(node)

function stairsplus.api.get_node_of_shaped_node(shaped_node)
function stairsplus.api.get_shape_of_shaped_node(shaped_node)

function stairsplus.api.register_on_register_craft_schema(func)
function stairsplus.api.register_craft_schema(schema)
function stairsplus.api.register_schema_crafts_for_node(node)
function stairsplus.api.register_crafts_for_shapes(recipe)

api.registered_shapes = {}
api.shapes_by_group = {}
function stairsplus.api.register_shape(name, def)

function stairsplus.api.station.update_infotext(pos)
function stairsplus.api.station.build_formspec(pos)
function stairsplus.api.station.get_cost(shaped_node)
function stairsplus.api.station.get_current_node(pos)
function stairsplus.api.station.can_dig(pos)
function stairsplus.api.station.on_receive_fields(pos, formname, fields, sender)
function stairsplus.api.station.update_inventory(pos, taken_stack)
function stairsplus.api.station.on_metadata_inventory_put(pos, listname, index, stack, player)
function stairsplus.api.station.on_metadata_inventory_take(pos, listname, index, stack, player)
-- Moving the inventory of the station around is not allowed because it
-- is a fictional inventory. Moving inventory around would be rather
-- impractical and make things more difficult to calculate:
function stairsplus.api.station.allow_metadata_inventory_move()
function stairsplus.api.station.allow_metadata_inventory_put(pos, listname, index, stack, player)
function stairsplus.api.station.on_construct(pos)
function stairsplus.api.station.after_place_node(pos, placer)
function stairsplus.api.register_station(name, shape_groups, def)


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

function stairsplus:register_alias_all(modname_old, subname_old, modname_new, subname_new)
function stairsplus:register_alias_force_all(modname_old, subname_old, modname_new, subname_new)
