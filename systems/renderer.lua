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

function Renderer:entityAdded(e)
    if e:hasAll('drawable', 'position') then
        self:insertOrdered(e)
        e.drawable.anim_counter = 1
        e.drawable.frame_counter = 1
        if self.textures[e.drawable.texture] == nil then
            self:loadTexture(e.drawable.texture)
        end
    end

    if e:has('draw_event') then
        self:draw()
    end

    if e:has('load_event') then
        self.world = e.load_event.world
    end

    if e:has('update_event') then
        self:update(e.update_event.dt)
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
        local offset = tex.offsets[e.drawable.frame]
        local x = e.position.x + offset.x
        local y = e.position.y + offset.y
        love.graphics.draw(tex.img, quad, x, y)
    end
end

function Renderer:update(dt)
    local ticks_per_frame = 3
    for _, e in pairs(self.entities) do
        if e.drawable.anim ~= nil then
            local tex = self.textures[e.drawable.texture]
            e.drawable.frame_counter = e.drawable.frame_counter + 1
            if e.drawable.frame_counter > ticks_per_frame then
                e.drawable.frame_counter = 0
                e.drawable.anim_counter = e.drawable.anim_counter + 1
                e.drawable.frame = tex.anims[e.drawable.anim][e.drawable.anim_counter]
                if e.drawable.anim_counter == #tex.anims[e.drawable.anim] then
                    local anim = e.drawable.anim
                    e.drawable.anim = nil
                    self.world:addEntity{anim_ended_event={entity=e, anim=anim}}
                end
            end
        end
    end
end

function Renderer:loadTexture(texture)
    local meta = love.filesystem.load('resources/' .. texture .. '.lua')()
    local img = love.graphics.newImage('resources/' .. meta.texture)
    local tex = {img=img, anims=meta.anims, quads={}, offsets={}}
    for k, v in pairs(meta.frames) do
        local x, y, w, h, ox, oy = unpack(v)
        tex.quads[k] = love.graphics.newQuad(x, y, w, h, img:getDimensions())
        tex.offsets[k] = {x=ox or 0, y=oy or 0}
    end
    self.textures[texture] = tex
end

return Renderer
