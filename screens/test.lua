local Entity = require('entity')
local Screen = require('screens.screen')
local Renderer = require('systems.renderer')

local TestScreen = {}
TestScreen.__index = TestScreen
setmetatable(TestScreen, Screen)

function TestScreen:load()
    print('loading test screen')

    self.systems = {
        renderer=Renderer:new()
    }

    local e = Entity:new{
        drawable={width=100, height=50},
        position={x=5, y=10}
    }

    for _, system in pairs(self.systems) do
        system:onEntityAdded(e)
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

return TestScreen
