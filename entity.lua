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

function Entity:has_any(...)
    for _, type in pairs({...}) do
        if self:has(type) then
            return true
        end
    end
    return false
end

function Entity:has_all(...)
    for _, type in pairs({...}) do
        if not self:has(type) then
            return false
        end
    end
    return true
end

return Entity
