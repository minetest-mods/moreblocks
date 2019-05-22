# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `settingtypes.txt` file to allow configuring settings in the main menu.
- Polish translation.

### Changed

- The minimum supported Minetest version is now 5.0.0.
- Stairs+ nodes now emit one light level less compared to full nodes to make up
  for their smaller visual size.

### Fixed

- Fixed a recipe conflict that made Centered Wooden Tiles impossible to craft.

## [1.3.0] - 2019-03-23

### Changed

- Stairs+ are now displayed in the creative inventory by default.
- Localization files now use the gettext `.po` format.
- Updated intllib support to avoid using deprecated functions.

### Fixed

- Node rotation now works correctly when placing Stairs+ nodes.
- Stairs+ glasslike nodes' textures are now easier to see.

## [1.2.0] - 2018-11-24

### Added

- Stairs+ nodes for `basic_materials`'s concrete, cement and brass blocks.
- Listring add for circular saw.
- **Stairs+:** New API function
  `stairsplus:register_custom_subset(subset, modname, subname, recipeitem, fields)`.

### Fixed

- The papyrus crafting recipe override is now properly applied over the
  `default` mod's recipe.
- Centered wooden tiles are now craftable.
- Wool Stairs+ nodes can no longer be used in crafting.
- The circular saw can no longer replace items from the player's inventory
  when it is full.

### Changed

- New crafting recipes for:
  - Stone Tile
  - Circle Stone Bricks
- Stairs+:
  - Moved definitions to `stairsplus.defs` table into a separate file.
  - Moved recipe definitions to `stairsplus.register_recipes` function
    into a separate file.

## [1.1.0] - 2017-10-04

### Added

- 3 new node shapes in the circular saw (thin slabs, available in
  "L-shaped", "corner-shaped" and "U-shaped" variations), all with 1/16
  thickness.
- New Stairs+ nodes:
  - Coral Skeleton
  - Desert Sandstone, Silver Sandstone
  - Desert Sandstone Brick, Silver Sandstone Brick
  - Desert Sandstone Block, Silver Sandstone Block
  - Obsidian Block
  - Sandstone Block
  - Stone Block, Desert Stone Block
  - Straw
  - Tin Block
  - Wool (all colors)
- Other mods can now get a list of all the defined Stairs+ shapes.

## 1.0.0 - 2017-02-19

- Initial versioned release.

[Unreleased]: https://github.com/minetest-mods/moreblocks/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/minetest-mods/moreblocks/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/minetest-mods/moreblocks/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/minetest-mods/moreblocks/compare/v1.0.0...v1.1.0
