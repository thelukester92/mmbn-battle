local System = require('systems.system')

local Battlefield = {}
Battlefield.__index = Battlefield
setmetatable(Battlefield, System)

function Battlefield:new()
    local o = System:new()
    setmetatable(o, self)
    o.entities = {}
    return o
end

function Battlefield:entityAdded(e)
    if e:has('grid_position') then
        table.insert(self.entities, e)
    end

    if e:has('load_event') then
        self:load(e.load_event.world)
    end

    if e:has('update_event') then
        self:update(e.update_event.dt)
    end
end

function Battlefield:load(world)
    for _, x in pairs({100, 140, 180}) do
        world:addEntity{
            drawable={texture='battlefield', frame='red_top'},
            position={x=x, y=100}
        }

        world:addEntity{
            drawable={texture='battlefield', frame='red_med'},
            position={x=x, y=124}
        }

        world:addEntity{
            drawable={texture='battlefield', frame='red_btm'},
            position={x=x, y=148}
        }
    end

    for _, x in pairs({220, 260, 300}) do
        world:addEntity{
            drawable={texture='battlefield', frame='blu_top'},
            position={x=x, y=100}
        }

        world:addEntity{
            drawable={texture='battlefield', frame='blu_med'},
            position={x=x, y=124}
        }

        world:addEntity{
            drawable={texture='battlefield', frame='blu_btm'},
            position={x=x, y=148}
        }
    end
end

function Battlefield:update(dt)
    for _, e in pairs(self.entities) do
        e.position.x = 100 + 40 * (e.grid_position.x - 1) + e.grid_position.offset_x
        e.position.y = 100 + 24 * (e.grid_position.y - 1) + e.grid_position.offset_y
    end
end

return Battlefield
