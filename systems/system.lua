local System = {}
System.__index = System

function System:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function System:entityAdded(e)
end

return System
