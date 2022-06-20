local dyes = {"white", "grey", "black", "red", "yellow", "green", "cyan",
              "blue", "magenta", "orange", "violet", "brown", "pink",
              "dark_grey", "dark_green"}

for _, name in ipairs(dyes) do
	local node = ("wool:%s"):format(name)
	stairsplus_legacy.register_legacy(node)
	stairsplus.api.register_alias_all(("moreblocks:%s"):format(name), node)
end
