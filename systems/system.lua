local System = {}
System.__index = System

function System:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function System:load()
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

function System:draw()
end

function System:update(dt)
end

function System:keypressed(key)
end

function System:keyreleased(key)
end

return System
