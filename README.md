# More Blocks [![Build status](https://github.com/minetest-mods/moreblocks/workflows/build/badge.svg)](https://github.com/minetest-mods/moreblocks/actions)

More Blocks for [Minetest](https://www.minetest.net/), a free and open source infinite
world block sandbox game.

![Screenshot](https://github.com/fluxionary/minetest-moreblocks/raw/bugfixes/screenshot.png)

![Screenshot](https://github.com/fluxionary/minetest-moreblocks/raw/bugfixes/screenshot2.png)

[Forum topic](https://forum.minetest.net/viewtopic.php?f=11&t=509)

[Content DB entry](https://content.minetest.net/packages/Calinou/moreblocks/)

[Source repo](https://github.com/minetest-mods/moreblocks/)

## Minetest Version compatibility

More Blocks is currently primarily tested with Minetest 5.5.0+.
It may or may not work with newer or older versions. Issues arising in older
versions than 5.0.0 will generally not be fixed.

## Legacy mode

The 3.0.0 release of moreblocks introduces a "legacy" mode, which is on by default, and is meant to
allow new servers to not commit to creating as many nodes as older versions, while not breaking anything
on existing servers. See `settingtypes.txt` for available settings.

# Mods in the pack

## moreblocks

Defines a bunch of new kinds of nodes. Provides an API for creating variants of some nodes.

## stairsplus

Allows the creation of 49 new shapes for registered nodes.

## stairsplus_legacy

Stairs+ registrations for various mods which were formerly done automatically as part of moreblocks.

## invsaw

Adds a button in unified_inventory that allows you to use the circular saw interface if you are
playing creatively, or have a circular saw item in your inventory and have the right priv
(`interact`, by default).

Invsaw was taken from [cheapie's invsaw mod](https://forum.minetest.net/viewtopic.php?t=14736), which
itself borrowed heavily from an older version of this mod. Flux decided to just add it here because it
needed to be fully rewritten to be compatible w/ their modifications to the stairsplus API.

# Documentation

## for players

## for admins

## for mod makers

see moreblocks/API.md and stairsplus/API.md

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
