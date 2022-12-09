local default_align_style = stairsplus.settings.default_align_style

local util = {}

-- get node settings to use for stairs
function util.get_node_vars(nodename)
	local def = minetest.registered_nodes[nodename]

	if def then
		return def.light_source, def.use_texture_alpha, def.sunlight_propagates
	end
end

function util.get_stair_images(images, worldaligntex)
	local stair_images = {}

	for i, image in ipairs(images) do
		local stair_image

		if type(image) == "string" then
			stair_image = {
				name = image,
				backface_culling = true,
			}

		else
			stair_image = table.copy(image)
			if stair_image.backface_culling == nil then
				stair_image.backface_culling = true
			end
		end

		if stair_image.align_style == nil then
			if worldaligntex then
				stair_image.align_style = "world"
			else
				stair_image.align_style = default_align_style
			end
		end

		stair_images[i] = stair_image
	end

	return stair_images
end

stairs.util = util
