--[[
More Blocks: Stairs+

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]


stairsplus.register_recipes = function(category, alternate, modname, subname, recipeitem)
	if category == "micro" and alternate == "" then
		core.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 7",
			recipe = {modname .. ":stair_" .. subname .. "_inner"},
		})

		core.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 6",
			recipe = {modname .. ":stair_" .. subname},
		})

		core.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 5",
			recipe = {modname .. ":stair_" .. subname .. "_outer"},
		})

		core.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 4",
			recipe = {modname .. ":slab_" .. subname},
		})

		core.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 4",
			recipe = {modname .. ":stair_" .. subname .. "_alt"},
		})

		core.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 3",
			recipe = {modname .. ":stair_" .. subname .. "_right_half"},
		})

		core.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 2",
			recipe = {modname .. ":panel_" .. subname},
		})

		core.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
		})

		core.register_alias(modname .. ":micro_" .. subname .. "_bottom", modname .. ":micro_" .. subname)
	elseif category == "panel" and alternate == "" then
		core.register_craft({
			output = modname .. ":panel_" .. subname .. " 12",
			recipe = {
				{recipeitem, ""},
				{recipeitem, recipeitem},
			},
		})

		core.register_craft({
			output = modname .. ":panel_" .. subname .. " 12",
			recipe = {
				{"", recipeitem},
				{recipeitem, recipeitem},
			},
		})

		core.register_craft({
			type = "shapeless",
			output = modname .. ":panel_" .. subname,
			recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
		})

		core.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
		})

		core.register_alias(modname.. ":panel_" ..subname.. "_bottom", modname.. ":panel_" ..subname)
	elseif category == "slab" then
		if alternate == "" then
			core.register_craft({
				output = modname .. ":slab_" .. subname .. " 6",
				recipe = {{recipeitem, recipeitem, recipeitem}},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})

			-- uncomment this rule when conflict is no longer likely to happen
			--	https://github.com/luanti-org/luanti/issues/2881
			-- core.register_craft({
			--	type = "shapeless",
			--	output = modname .. ":slab_" .. subname,
			--	recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
			-- })

			-- then remove these two
			core.register_craft({
				output = modname .. ":slab_" .. subname,
				recipe = {{modname .. ":panel_" .. subname, modname .. ":panel_" .. subname}},
			})

			core.register_craft({
				output = modname .. ":slab_" .. subname,
				recipe = {
					{modname .. ":panel_" .. subname},
					{modname .. ":panel_" .. subname},
				},
			})
			------------------------------

			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname, modname .. ":slab_" .. subname},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. " 3",
				recipe = {modname .. ":stair_" .. subname, modname .. ":stair_" .. subname},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_half", modname .. ":slope_" .. subname .. "_inner_half"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_cut_half", modname .. ":slope_" .. subname .. "_inner_cut_half"},
			})
		elseif alternate == "_quarter" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_three_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
			})
		elseif alternate == "_three_quarter" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_three_quarter",
				recipe = {modname .. ":slab_" .. subname, modname .. ":slab_" .. subname .. "_quarter"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_three_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_three_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})
		elseif alternate == "_2" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})

			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_14", modname .. ":slab_" .. subname .. "_2"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_2",
				recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
			})
		elseif alternate == "_14" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_14",
				recipe = {modname .. ":slab_" .. subname .. "_three_quarter", modname .. ":slab_" .. subname .. "_2"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_14",
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})
		elseif alternate == "_15" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_15", modname .. ":slab_" .. subname .. "_1"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_15",
				recipe = {modname .. ":slab_" .. subname .. "_14", modname .. ":slab_" .. subname .. "_1"},
			})
		end
	elseif category == "slope" then
		if alternate == "" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname, modname .. ":slope_" .. subname},
			})
		elseif alternate == "_half" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half_raised"},
			})

			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half",
					modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half"},
			})
		elseif alternate == "_outer" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer", modname .. ":slope_" .. subname .. "_inner"},
			})
		elseif alternate == "_outer_half" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_half", modname .. ":slope_" .. subname .. "_inner_half_raised"},
			})
		elseif alternate == "_inner_half" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_half_raised", modname .. ":slope_" .. subname .. "_inner_half"},
			})
		elseif alternate == "_outer_cut" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_cut", modname .. ":slope_" .. subname .. "_inner_cut"},
			})
		elseif alternate == "_outer_cut_half" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_cut_half", modname .. ":slope_" .. subname .. "_inner_cut_half_raised"},
			})
		elseif alternate == "_cut" then
			core.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_cut", modname .. ":slope_" .. subname .. "_cut"},
			})
		elseif alternate == "_half_raised" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_half_raised",
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half",
					modname .. ":slope_" .. subname .. "_half"},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_half"},
			})
		elseif alternate == "_inner_half_raised" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_inner_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_inner_half"},
			})
		elseif alternate == "_outer_half_raised" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_outer_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_outer_half"},
			})
		elseif alternate == "_inner_cut_half_raised" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_inner_cut_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_inner_cut_half"},
			})
		end
	elseif category == "stair" then
		if alternate == "" then
			core.register_craft({
				output = modname .. ":stair_" .. subname .. " 8",
				recipe = {
					{recipeitem, "", ""},
					{recipeitem, recipeitem, ""},
					{recipeitem, recipeitem, recipeitem},
				},
			})

			core.register_craft({
				output = modname .. ":stair_" .. subname .. " 8",
				recipe = {
					{"", "", recipeitem},
					{"", recipeitem, recipeitem},
					{recipeitem, recipeitem, recipeitem},
				},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":panel_" .. subname, modname .. ":slab_" .. subname},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
			})
		elseif alternate == "_inner" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_inner",
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})
		elseif alternate == "_outer" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_outer",
				recipe = {modname .. ":micro_" .. subname, modname .. ":slab_" .. subname},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_outer",
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})
		elseif alternate == "_half" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_half",
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})

			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_half",
				recipe = {modname .. ":panel_" .. subname, modname .. ":micro_" .. subname},
			})
		elseif alternate == "_right_half" then
			core.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_right_half",
				recipe = {modname .. ":stair_" .. subname .. "_half"},
			})
		elseif alternate == "_alt" then
			core.register_craft({ -- See mirrored variation of the recipe below.
				output = modname .. ":stair_" .. subname .. "_alt",
				recipe = {
					{modname .. ":panel_" .. subname, ""},
					{""                            , modname .. ":panel_" .. subname},
				},
			})

			core.register_craft({ -- Mirrored variation of the recipe above.
				output = modname .. ":stair_" .. subname .. "_alt",
				recipe = {
					{""                            , modname .. ":panel_" .. subname},
					{modname .. ":panel_" .. subname, ""},
				},
			})
		end
	end
end
