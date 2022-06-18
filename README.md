# More Blocks [![Build status](https://github.com/minetest-mods/moreblocks/workflows/build/badge.svg)](https://github.com/minetest-mods/moreblocks/actions)

More Blocks for [Minetest](https://www.minetest.net/), a free and open source infinite
world block sandbox game.

![Screenshot](./raw/bugfixes/screenshot.png)

![Screenshot](./raw/bugfixes/screenshot2.png)

[Forum topic](https://forum.minetest.net/viewtopic.php?f=11&t=509)

[Content DB entry](https://content.minetest.net/packages/Calinou/moreblocks/)

[Source repo](https://github.com/minetest-mods/moreblocks/)

## Version compatibility

More Blocks is currently primarily tested with Minetest 5.5.0+.
It may or may not work with newer or older versions. Issues arising in older
versions than 5.0.0 will generally not be fixed.

## Legacy mode

The 3.0.0 release of moreblocks introduces a "legacy" mode, which is on by default, and is meant to
allow new servers to not commit to creating as many nodes as older versions, while not breaking anything
on existing servers. See `settingtypes.txt` for available settings.

## Mods in the pack

### moreblocks

Defines a bunch of new kinds of nodes. Provides an API for creating variants of some nodes.

### stairsplus

Allows the creation of 49 new shapes for registered nodes.

### stairsplus_legacy

Stairs+ registrations for various mods which were formerly done automatically as part of moreblocks.

## License

Copyright © 2011-2022 Hugo Locurcio and contributors

- More Blocks code is licensed under the zlib license, see
  [`LICENSE.md`](LICENSE.md) for details.
- This is an altered version of the code which is not distributed by Hugo Locurcio.
- Unless otherwise specified, More Blocks textures are licensed under
  [CC BY-SA 3.0 Unported](https://creativecommons.org/licenses/by-sa/3.0/).
- `moreblocks_copperpatina.png` was created by pithydon, and is licensed under
  [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).
