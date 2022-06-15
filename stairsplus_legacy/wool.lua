local dyes = {"white", "grey", "black", "red", "yellow", "green", "cyan",
              "blue", "magenta", "orange", "violet", "brown", "pink",
              "dark_grey", "dark_green"}
for _, name in pairs(dyes) do
	local mod = "wool"
	local nodename = mod .. ":" .. name
	local ndef = table.copy(minetest.registered_nodes[nodename])
	ndef.sunlight_propagates = true

	stairsplus:register_all(mod, name, nodename, ndef)
end
