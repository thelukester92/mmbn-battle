local Component = {}
Component.__index = Component

function Component:new()
    local o = {}
    setmetatable(o, self)
    return o
end

return Component
