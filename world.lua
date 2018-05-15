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
    if e.__index ~= Entity then
        e = Entity:new(e)
    end
    table.insert(self.entities, e)
    for _, system in pairs(self.systems) do
        system:entityAdded(e)
    end
    return e
end

return World
