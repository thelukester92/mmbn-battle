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

function World:add_entity(e)
    if e.__index ~= Entity then
        e = Entity:new(e)
    end
    table.insert(self.entities, e)
    for _, system in pairs(self.systems) do
        system:entity_added(e)
    end
    return e
end

return World
