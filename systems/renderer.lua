local System = require('systems.system')

local Renderer = {}
Renderer.__index = Renderer
setmetatable(Renderer, System)

function Renderer:new()
    local o = System:new()
    setmetatable(o, self)
    o.entities = {}
    return o
end

function Renderer:accepts(e)
    print(e:has('drawable'), e:has('position'))
    return e:has('drawable') and e:has('position')
end

function Renderer:onAcceptedEntityAdded(e)
    table.insert(self.entities, e)
end

function Renderer:draw()
    for _, e in pairs(self.entities) do
        local drw = e:get('drawable')
        local pos = e:get('position')

        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('fill', pos.x, pos.y, drw.width, drw.height)
    end
end

function Renderer:update(dt)
    for _, e in pairs(self.entities) do
        local pos = e:get('position')
        pos.x = pos.x + 1
    end
end

return Renderer
