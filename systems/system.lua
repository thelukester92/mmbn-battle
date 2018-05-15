local System = {}
System.__index = System

function System:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function System:entity_added(e)
end

return System
