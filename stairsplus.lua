dofile(minetest.get_modpath("moreblocks").."/_config.txt")

-- Nodes will be called <modname>:{stair,slab,panel,micro}_<subname>

if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	stairsplus_expect_infinite_stacks = false
else
	stairsplus_expect_infinite_stacks = true
end

-- these vales are in order: facedir in degrees = 90, 0, 270, 180, 90

local dirs1 = { 21, 20, 23, 22, 21 }
local dirs2 = { 15, 8, 17, 6, 15 }
local dirs3 = { 14, 11, 16, 5, 14 }

stairsplus_players_onwall = {}

minetest.register_chatcommand("st", {
	params = "",
	description = "Toggle stairsplus between placing wall/vertical stairs/panels and normal.",
	func = function(name, param)
		stairsplus_players_onwall[name] = not stairsplus_players_onwall[name]

		if stairsplus_players_onwall[name] then
			 minetest.chat_send_player(name, "Stairsplus:  Placing wall stairs/vertical panels.")
		else
			 minetest.chat_send_player(name, "Stairsplus:  Placing floor/ceiling stairs/panels.")
		end
	end
})

stairsplus_can_it_stack = function(itemstack, placer, pointed_thing)
	return false
--[[
	if pointed_thing.type ~= "node" then
		return itemstack
	end

	-- If it's being placed on an another similar one, replace it with
	-- a full block
	local slabpos = nil
	local slabnode = nil
	local p1 = pointed_thing.above
	p1 = {x = p1.x, y = p1.y - 1, z = p1.z}
	local n1 = minetest.env:get_node(p1)
	if n1.name == modname .. ":slab_" .. subname then
		slabpos = p1
		slabnode = n1
	end
	if slabpos then
		-- Remove the slab at slabpos
		minetest.env:remove_node(slabpos)
		-- Make a fake stack of a single item and try to place it
		local fakestack = ItemStack(recipeitem)
		pointed_thing.above = slabpos
		fakestack = minetest.item_place(fakestack, placer, pointed_thing)
		-- If the item was taken from the fake stack, decrement original
		if not fakestack or fakestack:is_empty() then
			itemstack:take_item(1)
		-- Else put old node back
		else
			minetest.env:set_node(slabpos, slabnode)
		end
		return itemstack
	end

	if n1.name == modname .. ":slab_" .. subname .. "_quarter" then
		slabpos = p1
		slabnode = n1
	end
	if slabpos then
		-- Remove the slab at slabpos
		minetest.env:remove_node(slabpos)
		-- Make a fake stack of a single item and try to place it
		local fakestack = ItemStack(modname .. ":slab_" .. subname .. "_three_quarter")
		pointed_thing.above = slabpos
		fakestack = minetest.item_place(fakestack, placer, pointed_thing)
		-- If the item was taken from the fake stack, decrement original
		if not fakestack or fakestack:is_empty() then
			itemstack:take_item(1)
		-- Else put old node back
		else
			minetest.env:set_node(slabpos, slabnode)
		end
		return itemstack
	end

	-- Otherwise place regularly
	return minetest.item_place(itemstack, placer, pointed_thing)

]]--

end

local function get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
end

function stairsplus_rotate_and_place(itemstack, placer, pointed_thing, onwall)

	local node = minetest.env:get_node(pointed_thing.under)

	if not minetest.registered_nodes[node.name] or not minetest.registered_nodes[node.name].on_rightclick then

		local above = pointed_thing.above
		local under = pointed_thing.under
		local top = {x=under.x, y=under.y+1, z=under.z}

		local pitch = placer:get_look_pitch()
		local node = minetest.env:get_node(above)
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local wield_name = itemstack:get_name()

		local slab = string.find(wield_name, "slab")
		local panel = string.find(wield_name, "panel")
		local micro = string.find(wield_name, "micro")
		local iswall = (above.x ~= under.x) or (above.z ~= under.z)
		local isceiling = (above.x == under.x) and (above.z == under.z) and (pitch > 0)

		if get_nodedef_field(minetest.env:get_node(under).name, "buildable_to") then
			if slab then fdir = 0 end
			minetest.env:add_node(under, {name = wield_name, param2 = fdir }) -- place right side up
		elseif not get_nodedef_field(minetest.env:get_node(above).name, "buildable_to") then
			return
		elseif onwall or (iswall and (slab or panel)) then 
			if slab then
				minetest.env:add_node(above, {name = wield_name, param2 = dirs2[fdir+2] }) -- place with wall slab rotation
			else
				minetest.env:add_node(above, {name = wield_name, param2 = dirs3[fdir+2] }) -- place with wall panel/micro rotation
			end
		elseif isceiling then
			local nfdir = dirs1[fdir+2]
			if slab then nfdir = 22 end
			minetest.env:add_node(above, {name = wield_name, param2 = nfdir }) -- place upside down variant
		else
			if slab then fdir = 0 end
			minetest.env:add_node(above, {name = wield_name, param2 = fdir }) -- place right side up
		end

		if not stairsplus_expect_infinite_stacks then
			itemstack:take_item()
			return itemstack
		end
	else
		minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer)
	end
end

function register_stair_slab_panel_micro(modname, subname, recipeitem, groups, images, description, drop, light)
        if show_stairsplus_creative_inv then
                groups.not_in_creative_inventory = 0
        else
                groups.not_in_creative_inventory = 1
        end
        register_stair(modname, subname, recipeitem, groups, images, description, drop, light)
        register_slab( modname, subname, recipeitem, groups, images, description, drop, light)
        register_panel(modname, subname, recipeitem, groups, images, description, drop, light)
        register_micro(modname, subname, recipeitem, groups, images, description, drop, light)
        register_6dfacedir_conversion(modname, subname)
end

-- Default stairs/slabs/panels/microblocks

register_stair_slab_panel_micro("moreblocks", "wood", "default:wood",
	{snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	{"default_wood.png"},
	"Wooden",
	"wood",
	0)

register_stair_slab_panel_micro("moreblocks", "stone", "default:stone",
	{cracky=3},
	{"default_stone.png"},
	"Stone",
	"cobble",
	0)

register_stair_slab_panel_micro("moreblocks", "cobble", "default:cobble",
	{cracky=3},
	{"default_cobble.png"},
	"Cobblestone",
	"cobble",
	0)
	
register_stair_slab_panel_micro("moreblocks", "mossycobble", "default:mossycobble",
	{cracky=3},
	{"default_mossycobble.png"},
	"Mossy Cobblestone",
	"mossycobble",
	0)

register_stair_slab_panel_micro("moreblocks", "brick", "default:brick",
	{cracky=3},
	{"default_brick.png"},
	"Brick",
	"brick",
	0)

register_stair_slab_panel_micro("moreblocks", "sandstone", "default:sandstone",
	{crumbly=2,cracky=2},
	{"default_sandstone.png"},
	"Sandstone",
	"sandstone",
	0)
	
register_stair_slab_panel_micro("moreblocks", "steelblock", "default:steelblock",
	{cracky=1,level=2},
	{"default_steel_block.png"},
	"Steel Block",
	"steelblock",
	0)
	
register_stair_slab_panel_micro("moreblocks", "goldblock", "default:goldblock",
	{cracky=1},
	{"default_gold_block.png"},
	"Gold Block",
	"goldblock",
	0)
	
register_stair_slab_panel_micro("moreblocks", "copperblock", "default:copperblock",
	{cracky=1,level=2},
	{"default_copper_block.png"},
	"Copper Block",
	"copperblock",
	0)
	
register_stair_slab_panel_micro("moreblocks", "bronzeblock", "default:bronzeblock",
	{cracky=1,level=2},
	{"default_bronze_block.png"},
	"Bronze Block",
	"bronzeblock",
	0)
	
register_stair_slab_panel_micro("moreblocks", "diamondblock", "default:diamondblock",
	{cracky=1,level=3},
	{"default_diamond_block.png"},
	"Diamond Block",
	"diamondblock",
	0)
	
register_stair_slab_panel_micro("moreblocks", "desert_stone", "default:desert_stone",
	{cracky=3},
	{"default_desert_stone.png"},
	"Desert Stone",
	"desert_stone",
	0)
	
register_stair_slab_panel_micro("moreblocks", "glass", "default:glass",
	{snappy=2,cracky=3,oddly_breakable_by_hand=3},
	{"moreblocks_glass_stairsplus.png"},
	"Glass",
	"glass",
	0)
	
register_stair_slab_panel_micro("moreblocks", "tree", "default:tree",
	{tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	{"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	"Tree",
	"tree",
	0)
	
register_stair_slab_panel_micro("moreblocks", "jungletree", "default:jungletree",
	{tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	{"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	"Jungle Tree",
	"jungletree",
	0)
	
register_stair_slab_panel_micro("moreblocks", "obsidian", "default:obsidian",
	{cracky=1,level=2},
	{"default_obsidian.png"},
	"Obsidian",
	"obsidian",
	0)
	
register_stair_slab_panel_micro("moreblocks", "obsidian_glass", "default:obsidian_glass",
	{cracky=3,oddly_breakable_by_hand=3},
	{"moreblocks_obsidian_glass_stairsplus.png"},
	"Obsidian Glass",
	"obsidian_glass",
	0)
	
register_stair_slab_panel_micro("moreblocks", "stonebrick", "default:stonebrick",
	{cracky=3},
	{"default_stone_brick.png"},
	"Stone Bricks",
	"stone_bricks",
	0)
	
register_stair_slab_panel_micro("moreblocks", "desert_stonebrick", "default:desert_stonebrick",
	{cracky=3},
	{"default_desert_stone_brick.png"},
	"Desert Stone Bricks",
	"desert_stonebrick",
	0)
	
register_stair_slab_panel_micro("moreblocks", "sandstonebrick", "default:sandstonebrick",
	{cracky=3},
	{"default_sandstone_brick.png"},
	"Sandstone Bricks",
	"sandstonebrick",
	0)

-- More Blocks stairs/slabs/panels/microblocks
	
register_stair_slab_panel_micro("moreblocks", "circle_stone_bricks", "moreblocks:circle_stone_bricks",
	{cracky=3},
	{"moreblocks_circle_stone_bricks.png"},
	"Circle Stone Bricks",
	"circle_stone_bricks",
	0)
	
register_stair_slab_panel_micro("moreblocks", "iron_stone_bricks", "moreblocks:iron_stone_bricks",
	{cracky=3},
	{"moreblocks_iron_stone_bricks.png"},
	"Iron Stone Bricks",
	"iron_stone_bricks",
	0)
	
register_stair_slab_panel_micro("moreblocks", "stone_tile", "moreblocks:stone_tile",
	{cracky=3},
	{"moreblocks_stone_tile.png"},
	"Stonesquare",
	"stone_tile",
	0)
	
register_stair_slab_panel_micro("moreblocks", "split_stone_tile", "moreblocks:split_stone_tile",
	{cracky=3},
	{"moreblocks_split_stone_tile_top.png", "moreblocks_split_stone_tile.png"},
	"Split Stonesquare",
	"split_stone_tile",
	0)
	
register_stair_slab_panel_micro("moreblocks", "jungle_wood", "default:junglewood",
	{snappy=1, choppy=2, oddly_breakable_by_hand=2,flammable=3},
	{"default_junglewood.png"},
	"Jungle Wood",
	"jungle_wood",
	0)
	
register_stair_slab_panel_micro("moreblocks", "plankstone", "moreblocks:plankstone",
	{cracky=3},
	{"moreblocks_plankstone.png", "moreblocks_plankstone.png", "moreblocks_plankstone.png",
	"moreblocks_plankstone.png", "moreblocks_plankstone.png^[transformR90", "moreblocks_plankstone.png^[transformR90"},
	"Plankstone",
	"plankstone",
	0)
	
register_stair_slab_panel_micro("moreblocks", "coal_checker", "moreblocks:coal_checker",
	{cracky=3},
	{"moreblocks_coal_checker.png", "moreblocks_coal_checker.png", "moreblocks_coal_checker.png",
	"moreblocks_coal_checker.png", "moreblocks_coal_checker.png^[transformR90", "moreblocks_coal_checker.png^[transformR90"},
	"Coal Checker",
	"coal_checker",
	0)

register_stair_slab_panel_micro("moreblocks", "iron_checker", "moreblocks:iron_checker",
	{cracky=3},
	{"moreblocks_iron_checker.png", "moreblocks_iron_checker.png", "moreblocks_iron_checker.png",
	"moreblocks_iron_checker.png", "moreblocks_iron_checker.png^[transformR90", "moreblocks_iron_checker.png^[transformR90"},
	"Iron Checker",
	"iron_checker",
	0)
	
register_stair_slab_panel_micro("moreblocks", "cactus_checker", "moreblocks:cactus_checker",
	{cracky=3},
	{"moreblocks_cactus_checker.png", "moreblocks_cactus_checker.png", "moreblocks_cactus_checker.png",
	"moreblocks_cactus_checker.png", "moreblocks_cactus_checker.png^[transformR90", "moreblocks_cactus_checker.png^[transformR90"},
	"Cactus Checker",
	"cactus_checker",
	0)
	
register_stair_slab_panel_micro("moreblocks", "coal_stone", "moreblocks:coal_stone",
	{cracky=3},
	{"moreblocks_coal_stone.png"},
	"Coal Stone",
	"coal_stone",
	0)
	
register_stair_slab_panel_micro("moreblocks", "iron_stone", "moreblocks:iron_stone",
	{cracky=3},
	{"moreblocks_iron_stone.png"},
	"Iron Stone",
	"iron_stone",
	0)
	
register_stair_slab_panel_micro("moreblocks", "glow_glass", "moreblocks:glow_glass",
	{snappy=2,cracky=3,oddly_breakable_by_hand=3},
	{"moreblocks_glow_glass_stairsplus.png"},
	"Glow Glass",
	"glow_glass",
	11)
	
register_stair_slab_panel_micro("moreblocks", "super_glow_glass", "moreblocks:super_glow_glass",
	{snappy=2, cracky=3, oddly_breakable_by_hand=3},
	{"moreblocks_super_glow_glass_stairsplus.png"},
	"Super Glow Glass",
	"super_glow_glass",
	15)
	
register_stair_slab_panel_micro("moreblocks", "coal_glass", "moreblocks:coal_glass",
	{snappy=2, cracky=3, oddly_breakable_by_hand=3},
	{"moreblocks_coal_glass_stairsplus.png"},
	"Coal Glass",
	"coal_glass",
	0)
	
register_stair_slab_panel_micro("moreblocks", "iron_glass", "moreblocks:iron_glass",
	{snappy=2,cracky=3,oddly_breakable_by_hand=3},
	{"moreblocks_iron_glass_stairsplus.png"},
	"Iron Glass",
	"iron_glass",
	0)
	
register_stair_slab_panel_micro("moreblocks", "wood_tile", "moreblocks:wood_tile",
	{snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	{"moreblocks_wood_tile.png", "moreblocks_wood_tile.png", "moreblocks_wood_tile.png",
	"moreblocks_wood_tile.png", "moreblocks_wood_tile.png^[transformR90", "moreblocks_wood_tile.png^[transformR90"},
	"Wooden Tile",
	"wood_tile",
	0)
	
register_stair_slab_panel_micro("moreblocks", "wood_tile_center", "moreblocks:wood_tile_center",
	{snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	{"moreblocks_wood_tile_center.png", "moreblocks_wood_tile_center.png", "moreblocks_wood_tile_center.png",
	"moreblocks_wood_tile_center.png", "moreblocks_wood_tile_center.png^[transformR90", "moreblocks_wood_tile_center.png^[transformR90"},
	"Centered Wooden Tile",
	"wood_tile_center",
	0)

register_stair_slab_panel_micro("moreblocks", "wood_tile_full", "moreblocks:wood_tile_full",
	{snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	{"moreblocks_wood_tile_full.png", "moreblocks_wood_tile_full.png", "moreblocks_wood_tile_full.png",
	"moreblocks_wood_tile_full.png", "moreblocks_wood_tile_full.png^[transformR90", "moreblocks_wood_tile_full.png^[transformR90"},
	"Full Wooden Tile",
	"wood_tile_full",
	0)
