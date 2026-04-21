--[[
=====================================================================
** More Blocks **
By Calinou, with the help of ShadowNinja and VanessaE.

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
=====================================================================
--]]

moreblocks = {}

local modpath = core.get_modpath("moreblocks")

moreblocks.S = core.get_translator("moreblocks")

dofile(modpath .. "/config.lua")
dofile(modpath .. "/sounds.lua")
dofile(modpath .. "/circular_saw.lua")
dofile(modpath .. "/stairsplus/init.lua")

if core.get_modpath("default") then
    dofile(modpath .. "/nodes.lua")
    dofile(modpath .. "/redefinitions.lua")
    dofile(modpath .. "/crafting.lua")
    dofile(modpath .. "/aliases.lua")
end
