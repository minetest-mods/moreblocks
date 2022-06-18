stairsplus.dofile("shapes", "micros")
stairsplus.dofile("shapes", "panels")
stairsplus.dofile("shapes", "slabs")
stairsplus.dofile("shapes", "slopes")
stairsplus.dofile("shapes", "stairs")

stairsplus.api.shapes_by_group.basic = table.copy(stairsplus.settings.basic_shapes)
stairsplus.api.shapes_by_group.common = table.copy(stairsplus.settings.common_shapes)
