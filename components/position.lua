local Component = require('components.component')

local Position = {}
Position.__index = Position
setmetatable(Position, Component)

function Position:new(props)
    local o = {
        x=props.x or 0,
        y=props.y or 0
    }
    setmetatable(o, self)
    return o
end

return Position
