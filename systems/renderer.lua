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
    table.insert(self.entities, e)
    if self.textures[e.drawable.texture] == nil then
        self:loadTexture(e.drawable.texture)
    end
end

function Renderer:draw()
    for _, e in pairs(self.entities) do
        local tex = self.textures[e.drawable.texture]
        love.graphics.draw(tex.img, tex.quads[e.drawable.frame], e.position.x, e.position.y)
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
