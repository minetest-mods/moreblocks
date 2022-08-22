# More Blocks [![Build status](https://github.com/minetest-mods/moreblocks/workflows/build/badge.svg)](https://github.com/minetest-mods/moreblocks/actions)

More Blocks for [Minetest](https://www.minetest.net/), a free and open source infinite
world block sandbox game.

![Screenshot](https://github.com/fluxionary/minetest-moreblocks/raw/bugfixes/screenshot.png)

Stairsplus adds a large variety of new shapes for registered nodes:

![Screenshot](https://github.com/fluxionary/minetest-moreblocks/raw/bugfixes/screenshot2.png)

![Screenshot](https://github.com/fluxionary/minetest-moreblocks/raw/bugfixes/screenshot3.png)

[Forum topic](https://forum.minetest.net/viewtopic.php?f=11&t=509)

[Content DB entry](https://content.minetest.net/packages/Calinou/moreblocks/)

[Source repo](https://github.com/minetest-mods/moreblocks/)

# Mods in the pack

## moreblocks

Defines a bunch of new kinds of nodes. Provides an API for creating variants of some nodes.

## stairsplus

Allows the creation of 49 new shapes for registered nodes.

## stairsplus_legacy

Stairsplus registrations for various mods which were formerly done automatically as part of moreblocks.

## invsaw

Adds a button in unified_inventory that allows you to use the circular saw interface if you are
playing creatively, or have a circular saw item in your inventory and have the right priv
(`interact`, by default).

Invsaw was taken from [cheapie's invsaw mod](https://forum.minetest.net/viewtopic.php?t=14736), which
itself borrowed heavily from an older version of this mod. Flux decided to just add it here because it
needed to be fully rewritten to be compatible w/ their modifications to the stairsplus API.

# Documentation

## For players

Use of a decent inventory manager (e.g.
[unified_inventory](https://content.minetest.net/packages/RealBadAngel/unified_inventory/) or
[i3](https://content.minetest.net/packages/jp/i3/)) will help you figure out how to craft various nodes.

## For admins

### Minetest Version compatibility

More Blocks is currently primarily tested with Minetest 5.5.0+. It may or may not work with newer or
older versions. Issues arising in older versions will generally not be fixed.

### Legacy mode

The 3.0.0 release of moreblocks introduces a "legacy" mode, which is on by default, and is meant to
allow new servers to not commit to creating as many nodes as older versions, while not breaking anything
on existing servers. See `settingtypes.txt` for available settings.

By defaulthe 3.0.0 release disables certain recipe overrides that were part of moreblocks 2.*. To re-enable
them, set `moreblocks_legacy_recipes.enabled = true`.

### Settings

See `settingtypes.txt` for available settings.

### Dependencies

Moreblocks and stairsplus do not have hard dependencies on other mods. Invsaw depends on `unified_inventory`
and stairsplus.

### Compatability

Moreblocks currently supports resources from a number of mods and minetest_game. Without these installed,
some things may not be craftable, may have low-quality textures, or may not have "node sounds" registered.
If available, resources will be used from `bucket`, `default`, `rhotator`, `screwdriver`, and `vessels`.

If the `stairsplus_legacy` mod is enabled, stairsplus nodes will automatically be registered for the following
mods, if they are available: `basic_materials`, `default`, `farming`, `gloopblocks`, `prefab`, `technic`,
and `wool`.

## For mod makers

See moreblocks/API.md and stairsplus/API.md.

# License

## moreblocks, stairsplus, stairsplus legacy
Copyright © 2011-2022 Hugo Locurcio and contributors

- More Blocks code is licensed under the zlib license, see
  [`LICENSE.md`](LICENSE.md) for details.
- This is an altered version of the code which is not distributed by Hugo Locurcio.

- Unless otherwise specified, More Blocks textures are licensed under
  [CC BY-SA 3.0 Unported](https://creativecommons.org/licenses/by-sa/3.0/).
- `moreblocks_copperpatina.png` was created by pithydon, and is licensed under
  [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).
- `stairsplus_saw_button.png` CC BY-SA 3.0 Unported

## invsaw

Copyright © ?-2022 cheapie and contributors

- invsaw code is licensed under the zlib license, see
  [`LICENSE.md`](LICENSE.md) for details.
- This is an altered version of the code which is not distributed by cheapie.
