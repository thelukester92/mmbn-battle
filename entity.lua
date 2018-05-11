local Entity = {}
Entity.__index = Entity

function Entity:new(comps)
    local o = {}
    setmetatable(o, Entity)

    for type, comp in pairs(comps) do
        o[type] = comp
    end

    return o
end

function Entity:has(type)
    return self[type] ~= nil
end

return Entity
