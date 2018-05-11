local Entity = require('entity')
local System = require('systems.system')

local Battlefield = {}
Battlefield.__index = Battlefield
setmetatable(Battlefield, System)

function Battlefield:new()
    local o = System:new()
    setmetatable(o, self)
    return o
end

function Battlefield:load(world)
    for _, x in pairs({100, 140, 180}) do
        world:addEntity(Entity:new{
            drawable={texture='battlefield', frame='red_top'},
            position={x=x, y=100}
        })

        world:addEntity(Entity:new{
            drawable={texture='battlefield', frame='red_med'},
            position={x=x, y=124}
        })

        world:addEntity(Entity:new{
            drawable={texture='battlefield', frame='red_btm'},
            position={x=x, y=148}
        })
    end

    for _, x in pairs({220, 260, 300}) do
        world:addEntity(Entity:new{
            drawable={texture='battlefield', frame='blu_top'},
            position={x=x, y=100}
        })

        world:addEntity(Entity:new{
            drawable={texture='battlefield', frame='blu_med'},
            position={x=x, y=124}
        })

        world:addEntity(Entity:new{
            drawable={texture='battlefield', frame='blu_btm'},
            position={x=x, y=148}
        })
    end
end

return Battlefield
