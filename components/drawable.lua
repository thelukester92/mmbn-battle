local Component = require('components.component')

local Drawable = {}
Drawable.__index = Drawable
setmetatable(Drawable, Component)

function Drawable:new(props)
    local o = {
        width=props.width,
        height=props.height
    }
    setmetatable(o, self)
    return o
end

return Drawable
