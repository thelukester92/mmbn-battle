local System = {}
System.__index = System

function System:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function System:accepts(e)
    return false
end

function System:onEntityAdded(e)
    if self:accepts(e) then
        self:onAcceptedEntityAdded(e)
    end
end

function System:onAcceptedEntityAdded(e)
end

function System:update(dt)
end

return System
