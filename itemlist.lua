--[[
    show_item_list form for Minetest mods
    (c) Pierre-Yves Rollo

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

--[[ The item list dialog can only be displayed from within a node formspec.
To open the item list dialog, add a do_file :

local show_item_list = dofile(
	minetest.get_modpath(minetest.get_current_modname())..'/itemlist.lua')

...

-- From your on_receive_field, call :
show_item_list(player, title, item_list, pos_context)

player: player name or object
title: title to be displayed at the top of the dialog
item_list: a list of item names
pos_context: position of the context node (node that openned the formspec)
]]--

-- Formspec style

local style={
	linesize = 0.9, -- Line height
	colsize = 4,    -- Column width
	lines = 8,      -- Number of lines of items displayed
	cols = 3,       -- Number of columns of items displayed
}

local modname = minetest.get_current_modname()

-- Context management functions (surely many improvements to do)

local contexts = {}

local function get_player_name(player)
	if type(player) == 'string' then
		return player
	end
	if type(player) == 'userdata' and player.get_player_name then
		return player:get_player_name()
	end
	minetest.log('warning',	'['..modname..'] get_player_name could not identify player.')
end

minetest.register_on_leaveplayer(function(player)
	local playername = get_player_name(player)
	if playername then
		contexts[playername] = nil
	end
end)

local function get_context(player)
	local playername = get_player_name(player)
	if playername then
		if not contexts[playername] then
			contexts[playername] = { playername = playername }
		end
		return contexts[playername]
	end
end

-- Show node formspec functions

local function show_node_formspec(player, pos)
	local meta = minetest.get_meta(pos)
	local playername = get_player_name(player)

	-- Decontextualize formspec
	local fs = meta:get_string('formspec')

	-- Change context and currrent_name references to nodemeta references
	local nodemeta = string.format("nodemeta:%i,%i,%i", pos.x, pos.y ,pos.z)
	fs = fs:gsub("current_name", nodemeta)
	fs = fs:gsub("context", nodemeta)

	-- Change all ${} to their corresponding metadata values
	local s, e
	repeat
		s, e = fs:find('%${.*}')
		if s and e then
			fs = fs:sub(1, s-1)..
				minetest.formspec_escape(meta:get_string(fs:sub(s+2,e-1)))..
				fs:sub(e+1)
		end
	until s == nil

	-- Find node on_receive_fields
	local ndef = minetest.registered_nodes[minetest.get_node(pos).name]

	local context = get_context(player)
	context.node_pos = pos

	if ndef and ndef.on_receive_fields then
		context.on_receive_fields = ndef.on_receive_fields
	end

	-- Show formspec
	minetest.show_formspec(playername, modname..':context_formspec', fs)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == modname..':context_formspec' then
		local context = get_context(player)
		if context == nil then
			return
		end

		if context.on_receive_fields then
			context.on_receive_fields(context.node_pos, '', fields, player)
		end
	end
end)

-- Specific functions

local function get_nb_of_pages(context)
	return math.ceil((#context.items + 1) / (style.lines * style.cols))
end

local function item_list_prepare(item_list)
	local list = {}
	for _, name in ipairs(item_list) do
		local ndef = minetest.registered_items[name]
		if ndef then
			list[#list+1] = ndef
		end
	end
	table.sort(list, function(a,b) return a.description < b.description end)
	return list
end

local function show_item_list_formspec(player)
	local context = get_context(player)
	if context == nil then
		return
	end

	local fs = 'size['..(style.colsize * style.cols)..','
		..(style.linesize * style.lines + 1.3)..']'
		..default.gui_bg..default.gui_bg_img..default.gui_slots
		..'label[1,0;'..context.title..']'
		..'button_exit['..(style.colsize * style.cols - 2)..','
		..(style.linesize * style.lines + 0.7)..';2,1;close;Close]'

	if context.page > 1 then
	 	fs = fs..'button['..(style.colsize * style.cols - 2)..',-0.2;1,1;prev;<]'
	end

	if context.page < get_nb_of_pages(context) then
		fs = fs..'button['..(style.colsize * style.cols - 1)..',-0.2;1,1;next;>]'
	end

	local index = (style.lines * style.cols) * (context.page - 1)

	for col = 1, style.cols do
		local x = (col - 1) * style.colsize
		for line = 1, style.lines do
			index = index + 1
			local y = line * style.linesize - 0.2
			if context.items[index] then
				fs = fs..'item_image['..x..','..y..';1,1;'
				..context.items[index].name..']label['..(x+1)..','..(y+0.2)..';'
				..(context.items[index].description or context.items[index].name)
				..']'
			end
		end
	end
	minetest.show_formspec(context.playername, modname..':item_list', fs)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= modname..':item_list' then
		return
	end

	local context = get_context(player)
	if context == nil then
		return
	end

	if fields.next then
		context.page = context.page + 1
		show_item_list_formspec(context.playername)
	end
	if fields.prev then
		context.page = context.page - 1
		show_item_list_formspec(context.playername)
	end
	if fields.quit == 'true' then
		if context.node_pos then
			-- Using after to avoid the "double close" bug
			minetest.after(0, show_node_formspec, get_player_name(player),
				context.node_pos)
		end
	end
end)

-- Only exposed function - Entry point

local function show_item_list(player, title, item_list, pos_context)
	local context = get_context(player)
	context.items = item_list_prepare(item_list)
	context.title = title
	context.node_pos = pos_context
	context.page = 1
	show_item_list_formspec(player)
end

return show_item_list
