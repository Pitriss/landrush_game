-- Vines

local VINE_GROW_CHANCE = 5
local VINE_GROW_DELAY = 1200

-- Nodes
minetest.register_node("vines:vine", {
    description = "Vine",
    walkable = false,
    climbable = true,
    sunlight_propagates = true,
    paramtype = "light",
    tiles = { "vines_vine.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
    drop = "vines:vine",
})

minetest.register_node("vines:vine_rotten", {
    description = "Rotten vine",
    walkable = false,
    climbable = false,
    sunlight_propagates = true,
    paramtype = "light",
    tiles = { "vines_vine_rotten.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine_rotten.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
    drop = "vines:vine_rotten",
})

--[[ ABMs (growing)
minetest.register_abm({
    nodenames = "vines:vine",
    interval = VINE_GROW_DELAY,
    chance = VINE_GROW_CHANCE,

    action = function(pos, node, _, _)
	local under = {
	    x = pos.x,
	    y = pos.y - 1,
	    z = pos.z,
	}
	local under_name = minetest.get_node(under).name

	if under_name ~= "vines:vine"
		and under_name ~= "default:dirt"
		and under_name ~= "default:dirt_with_grass" then
	    nature:grow_node(pos, "vines:vine_rotten")
	else

	    if(minetest.get_node_light(pos, nil) < 4) then
		return
	    end
 
	    local above = {
		x = pos.x,
		y = pos.y + 1,
		z = pos.z,
	    }

	    if minetest.get_node(above).name == "air" then
		nature:grow_node(above, "vines:vine")
	    end
	end
    end
})

minetest.register_abm({
    nodenames = "vines:vine_rotten",
    interval = 1200,
    chance = VINE_ROT_CHANCE,

    action = function(pos, node, _, _)
	minetest.remove_node(pos)
	local under = {
	    x = pos.x,
	    y = pos.y - 1,
	    z = pos.z,
	}
	local under_name = minetest.get_node(under).name

	if under_name == "vines:vine"
		or under_name == "default:dirt"
		or under_name == "default:dirt_with_grass" then
	    nature:grow_node(above, "vines:vine")
	end
    end
})
]]
-- Growing on the ground
--
--[[plantslib:spawn_on_surfaces(3600, "vines:vine", 30, 3, "default:dirt_with_grass",
	"group:flower")]]
