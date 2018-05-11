local Entity = require('entity')
local Screen = require('screens.screen')
local Battlefield = require('systems.battlefield')
local Renderer = require('systems.renderer')

local TestScreen = {}
TestScreen.__index = TestScreen
setmetatable(TestScreen, Screen)

function TestScreen:load()
    self.entities = {}
    self.systems = {
        battlefield=Battlefield:new(),
        renderer=Renderer:new()
    }

    for _, system in pairs(self.systems) do
        system:load(self)
    end
end

function TestScreen:draw()
    for _, system in pairs(self.systems) do
        system:draw()
    end
end

function TestScreen:update(dt)
    for _, system in pairs(self.systems) do
        system:update(dt)
    end
end

function TestScreen:addEntity(e)
    table.insert(self.entities, e)
    for _, system in pairs(self.systems) do
        system:onEntityAdded(e)
    end
end

return TestScreen
