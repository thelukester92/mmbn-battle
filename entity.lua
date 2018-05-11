local Component = require('components.component')
local ComponentFactory = require('components.factory')

local Entity = {}
Entity.__index = Entity

function Entity:new(e)
    local o = {}
    setmetatable(o, self)
    o:load(e)
    return o
end

function Entity:load(e)
    for type, props in pairs(e) do
        self[type] = ComponentFactory:newComponent(type, props)
    end
end

function Entity:has(type)
    return self[type] ~= nil
end

function Entity:get(type)
    return self[type]
end

return Entity
