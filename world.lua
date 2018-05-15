local Entity = require('entity')

local World = {}
World.__index = World

function World:new(systems)
    local o = {
        entities={},
        systems=systems
    }
    setmetatable(o, self)
    return o
end

function World:addEntity(e)
    e = Entity:new(e)
    table.insert(self.entities, e)
    for _, system in pairs(self.systems) do
        system:entityAdded(e)
    end
end

return World
