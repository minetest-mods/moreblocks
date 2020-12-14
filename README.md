# More Blocks [![Build status](https://github.com/minetest-mods/moreblocks/workflows/build/badge.svg)](https://github.com/minetest-mods/moreblocks/actions)

More Blocks for [Minetest](https://www.minetest.net/), a free and open source infinite
world block sandbox game.

[**Forum topic**](https://forum.minetest.net/viewtopic.php?f=11&t=509)

## Installation

### Download the mod

To install More Blocks, clone this Git repository into your Minetest's `mods/`
directory:

```bash
git clone https://github.com/minetest-mods/moreblocks.git
```

You can also
[download a ZIP archive](https://github.com/minetest-mods/moreblocks/archive/master.zip)
of More Blocks.

### Enable the mod

Once you have installed More Blocks, you need to enable it in Minetest.
The procedure is as follows:

#### Using the client's main menu

This is the easiest way to enable More Blocks when playing in singleplayer
(or on a server hosted from a client).

1. Start Minetest and switch to the **Local Game** tab.
2. Select the world you want to enable More Blocks in.
3. Click **Configure**, then enable `moreblocks` by double-clicking it
   (or ticking the **Enabled** checkbox).
4. Save the changes, then start a game on the world you enabled More Blocks on.
5. More Blocks should now be running on your world.

#### Using a text editor

This is the recommended way to enable the mod on a server without using a GUI.

1. Make sure Minetest is not currently running (otherwise, it will overwrite
   the changes when exiting).
2. Open the world's `world.mt` file using a text editor.
3. Add the following line at the end of the file:

```text
load_mod_moreblocks = true
```

If the line is already present in the file, then replace `false` with `true`
on that line.

4. Save the file, then start a game on the world you enabled More Blocks on.
5. More Blocks should now be running on your world.

## Version compatibility

More Blocks is currently primarily tested with Minetest 5.3.0.
It may or may not work with newer or older versions. Issues arising in older
versions than 5.0.0 will generally not be fixed.

## License

Copyright © 2011-2020 Hugo Locurcio and contributors

- More Blocks code is licensed under the zlib license, see
  [`LICENSE.md`](LICENSE.md) for details.
- Unless otherwise specified, More Blocks textures are licensed under
  [CC BY-SA 3.0 Unported](https://creativecommons.org/licenses/by-sa/3.0/).

`moreblocks_copperpatina.png` was created by pithydon, and is licensed under
[CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).
