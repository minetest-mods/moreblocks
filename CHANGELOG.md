# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Listring add for circular saw.
- Stairs+: New API function:
 `stairsplus:register_custom_subset(subset, modname, subname, recipeitem, fields)`

### Fixed

- Wool Stairs+ nodes can no longer be used in crafting.
- The circular saw can no longer replace items from the player's inventory
  when it is full.

### Changed

- New craft for:
  - Stone Tile
  - Circle Stone Bricks
- Stairs+:
  - Move definitions to `stairsplus.defs` table in a separate file
  - Move recipe definitions to `stairsplus.register_recipes` function in a separate file

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
- Other mods can now get a list of all the defined Stairs+ shapes

## 1.0.0 - 2017-02-19

- Initial versioned release.

[Unreleased]: https://github.com/minetest-mods/moreblocks/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/minetest-mods/moreblocks/compare/v1.0.0...v1.1.0
