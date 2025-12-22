--[[
More Blocks: registrations

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]


local box_slope = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local box_slope_half = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -0.5,  0.5, -0.375, 0.5},
		{-0.5, -0.375, -0.25, 0.5, -0.25,  0.5},
		{-0.5, -0.25,  0,    0.5, -0.125, 0.5},
		{-0.5, -0.125, 0.25, 0.5,  0,     0.5},
	}
}

local box_slope_half_raised = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -0.5,  0.5, 0.125, 0.5},
		{-0.5, 0.125, -0.25, 0.5, 0.25,  0.5},
		{-0.5, 0.25,  0,    0.5, 0.375, 0.5},
		{-0.5, 0.375, 0.25, 0.5,  0.5,     0.5},
	}
}

--==============================================================

local box_slope_inner = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5},
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5},
		{-0.5, 0, -0.5, 0, 0.25, 0.5},
		{-0.5, 0, 0, 0.5, 0.25, 0.5},
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
	}
}

local box_slope_inner_half = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
		{-0.5, -0.375, -0.25, 0.5, -0.25, 0.5},
		{-0.5, -0.375, -0.5, 0.25, -0.25, 0.5},
		{-0.5, -0.25, -0.5, 0, -0.125, 0.5},
		{-0.5, -0.25, 0, 0.5, -0.125, 0.5},
		{-0.5, -0.125, 0.25, 0.5, 0, 0.5},
		{-0.5, -0.125, -0.5, -0.25, 0, 0.5},
	}
}

local box_slope_inner_half_raised = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
		{-0.5, 0.125, -0.25, 0.5, 0.25, 0.5},
		{-0.5, 0.125, -0.5, 0.25, 0.25, 0.5},
		{-0.5, 0.25, -0.5, 0, 0.375, 0.5},
		{-0.5, 0.25, 0, 0.5, 0.375, 0.5},
		{-0.5, 0.375, 0.25, 0.5, 0.5, 0.5},
		{-0.5, 0.375, -0.5, -0.25, 0.5, 0.5},
	}
}

--==============================================================

local box_slope_outer = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}

local box_slope_outer_half = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.375, 0.5},
		{-0.5, -0.375, -0.25,  0.25, -0.25, 0.5},
		{-0.5,  -0.25,     0,     0, -0.125, 0.5},
		{-0.5,  -0.125,  0.25, -0.25, 0, 0.5}
	}
}

local box_slope_outer_half_raised = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, 0.125, 0.5},
		{-0.5, 0.125, -0.25,  0.25, 0.25, 0.5},
		{-0.5,  0.25,     0,     0, 0.375, 0.5},
		{-0.5,  0.375,  0.25, -0.25, 0.5, 0.5}
	}
}

stairsplus.defs = {
	["micro"] = {
		[""] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
			},
		},
		["_1"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, -0.4375, 0.5},
			},
		},
		["_2"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, -0.375, 0.5},
			},
		},
		["_4"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, -0.25, 0.5},
			},
		},
		["_12"] = {
			_circular_saw_cost = 2,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, 0.25, 0.5},
			},
		},
		["_14"] = {
			_circular_saw_cost = 2,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, 0.375, 0.5},
			},
		},
		["_15"] = {
			_circular_saw_cost = 2,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0, 0.4375, 0.5},
			},
		}
	},
	["panel"] = {
		[""] = {
			_circular_saw_cost = 2,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		["_1"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
			},
		},
		["_2"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
			},
		},
		["_4"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, -0.25, 0.5},
			},
		},
		["_12"] = {
			_circular_saw_cost = 3,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0.25, 0.5},
			},
		},
		["_14"] = {
			_circular_saw_cost = 4,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0.375, 0.5},
			},
		},
		["_15"] = {
			_circular_saw_cost = 4,
			node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, 0, 0.5, 0.4375, 0.5},
			},
		}
	},
	["slab"] = {
		[""] = {
			_circular_saw_cost = 4,
			size = 8
		},
		["_quarter"] = {
			_circular_saw_cost = 2,
			size = 4
		},
		["_three_quarter"] = {
			_circular_saw_cost = 6,
			size = 12
		},
		["_1"] = {
			_circular_saw_cost = 1,
			size = 1
		},
		["_2"] = {
			_circular_saw_cost = 1,
			size = 2
		},
		["_14"] = {
			_circular_saw_cost = 7,
			size = 14
		},
		["_15"] = {
			_circular_saw_cost = 8,
			size = 15;
		},
		["_two_sides"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {
					{ -0.5, -0.5, -0.5, 0.5, -7/16, 7/16 },
					{ -0.5, -0.5, 7/16, 0.5, 0.5, 0.5 }
				}
			};
		},
		["_three_sides"] = {
			_circular_saw_cost = 2,
			node_box = {
				type = "fixed",
				fixed = {
					{ -7/16, -0.5, -0.5, 0.5, -7/16, 7/16 },
					{ -7/16, -0.5, 7/16, 0.5, 0.5, 0.5 },
					{ -0.5, -0.5, -0.5, -7/16, 0.5, 0.5 }
				}
			}
		},
		["_three_sides_u"] = {
			_circular_saw_cost = 2,
			node_box = {
				type = "fixed",
				fixed = {
					{ -0.5, -0.5, -0.5, 0.5, 0.5, -7/16 },
					{ -0.5, -0.5, -7/16, 0.5, -7/16, 7/16 },
					{ -0.5, -0.5, 7/16, 0.5, 0.5, 0.5 }
				}
			}
		}
	},
	["slope"] = {
		[""] = {
			_circular_saw_cost = 4,
			mesh = "moreblocks_slope.obj",
			collision_box = box_slope,
			selection_box = box_slope,

		},
		["_half"] = {
			_circular_saw_cost = 2,
			mesh = "moreblocks_slope_half.obj",
			collision_box = box_slope_half,
			selection_box = box_slope_half,
		},
		["_half_raised"] = {
			_circular_saw_cost = 6,
			mesh = "moreblocks_slope_half_raised.obj",
			collision_box = box_slope_half_raised,
			selection_box = box_slope_half_raised,
		},

		--==============================================================

		["_inner"] = {
			_circular_saw_cost = 7,
			mesh = "moreblocks_slope_inner.obj",
			collision_box = box_slope_inner,
			selection_box = box_slope_inner,
		},
		["_inner_half"] = {
			_circular_saw_cost = 3,
			mesh = "moreblocks_slope_inner_half.obj",
			collision_box = box_slope_inner_half,
			selection_box = box_slope_inner_half,
		},
		["_inner_half_raised"] = {
			_circular_saw_cost = 7,
			mesh = "moreblocks_slope_inner_half_raised.obj",
			collision_box = box_slope_inner_half_raised,
			selection_box = box_slope_inner_half_raised,
		},

		--==============================================================

		["_inner_cut"] = {
			_circular_saw_cost = 7,
			mesh = "moreblocks_slope_inner_cut.obj",
			collision_box = box_slope_inner,
			selection_box = box_slope_inner,
		},
		["_inner_cut_half"] = {
			_circular_saw_cost = 4,
			mesh = "moreblocks_slope_inner_cut_half.obj",
			collision_box = box_slope_inner_half,
			selection_box = box_slope_inner_half,
		},
		["_inner_cut_half_raised"] = {
			_circular_saw_cost = 8,
			mesh = "moreblocks_slope_inner_cut_half_raised.obj",
			collision_box = box_slope_inner_half_raised,
			selection_box = box_slope_inner_half_raised,
		},

		--==============================================================

		["_outer"] = {
			_circular_saw_cost = 3,
			mesh = "moreblocks_slope_outer.obj",
			collision_box = box_slope_outer,
			selection_box = box_slope_outer,
		},
		["_outer_half"] = {
			_circular_saw_cost = 2,
			mesh = "moreblocks_slope_outer_half.obj",
			collision_box = box_slope_outer_half,
			selection_box = box_slope_outer_half,
		},
		["_outer_half_raised"] = {
			_circular_saw_cost = 6,
			mesh = "moreblocks_slope_outer_half_raised.obj",
			collision_box = box_slope_outer_half_raised,
			selection_box = box_slope_outer_half_raised,
		},

		--==============================================================

		["_outer_cut"] = {
			_circular_saw_cost = 2,
			mesh = "moreblocks_slope_outer_cut.obj",
			collision_box = box_slope_outer,
			selection_box = box_slope_outer,
		},
		["_outer_cut_half"] = {
			_circular_saw_cost = 1,
			mesh = "moreblocks_slope_outer_cut_half.obj",
			collision_box = box_slope_outer_half,
			selection_box = box_slope_outer_half,
		},
		["_outer_cut_half_raised"] = {
			_circular_saw_cost = 3,
			mesh = "moreblocks_slope_outer_cut_half_raised.obj",
			collision_box = box_slope_outer_half_raised,
			selection_box = box_slope_outer_half_raised,
		},
		["_cut"] = {
			_circular_saw_cost = 4,
			mesh = "moreblocks_slope_cut.obj",
			collision_box = box_slope_outer,
			selection_box = box_slope_outer,
		},
	},
	["stair"] = {
		[""] = {
			_circular_saw_cost = 6,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_half"] = {
			_circular_saw_cost = 3,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0, 0, 0.5},
					{-0.5, 0, 0, 0, 0.5, 0.5},
				},
			},
		},
		-- TODO FIXME not included in circular_saw.names
		["_right_half"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{0, -0.5, -0.5, 0.5, 0, 0.5},
					{0, 0, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_inner"] = {
			_circular_saw_cost = 7,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
					{-0.5, 0, -0.5, 0, 0.5, 0},
				},
			},
		},
		["_outer"] = {
			_circular_saw_cost = 5,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0, 0.5, 0.5},
				},
			},
		},
		["_alt"] = {
			_circular_saw_cost = 4,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_alt_1"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.0625, -0.5, 0.5, 0, 0},
					{-0.5, 0.4375, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_alt_2"] = {
			_circular_saw_cost = 1,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.125, -0.5, 0.5, 0, 0},
					{-0.5, 0.375, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_alt_4"] = {
			_circular_saw_cost = 2,
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.25, -0.5, 0.5, 0, 0},
					{-0.5, 0.25, 0, 0.5, 0.5, 0.5},
				},
			},
		},
	},
}

for type,a in pairs(stairsplus.defs) do
	for name,b in pairs(stairsplus.defs[type]) do
		table.insert(stairsplus.shapes_list, { type .. "_", name })
	end
end
