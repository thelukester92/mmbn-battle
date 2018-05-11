local System = require('systems.system')
local Renderer = {}
Renderer.__index = Renderer
setmetatable(Renderer, System)

function Renderer:new()
    local o = System:new()
    setmetatable(o, self)
    o.entities = {}
    o.textures = {}
    return o
end

function Renderer:accepts(e)
    return e:has('drawable') and e:has('position')
end

function Renderer:onAcceptedEntityAdded(e)
    self:insertOrdered(e)
    if self.textures[e.drawable.texture] == nil then
        self:loadTexture(e.drawable.texture)
    end
end

function Renderer:insertOrdered(e)
    e.drawable.zIndex = e.drawable.zIndex or 0
    for i = 1,#self.entities do
        if e.drawable.zIndex < self.entities[i].drawable.zIndex then
            table.insert(self.entities, i, e)
            return
        end
    end
    table.insert(self.entities, e)
end

function Renderer:draw()
    for _, e in pairs(self.entities) do
        local tex = self.textures[e.drawable.texture]
        local quad = tex.quads[e.drawable.frame]
        love.graphics.draw(tex.img, quad, e.position.x, e.position.y)
    end
end

function Renderer:loadTexture(texture)
    local meta = love.filesystem.load('resources/' .. texture .. '.lua')()
    local img = love.graphics.newImage('resources/' .. meta.texture)
    local tex = {img=img, quads={}}
    for k, v in pairs(meta.frames) do
        local x, y, w, h = unpack(v)
        tex.quads[k] = love.graphics.newQuad(x, y, w, h, img:getDimensions())
    end
    self.textures[texture] = tex
end

return Renderer
