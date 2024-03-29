local Screen = require('screens.screen')

local Battlefield = require('systems.battlefield')
local Player = require('systems.player')
local Renderer = require('systems.renderer')
local World = require('world')

local TestScreen = {}
TestScreen.__index = TestScreen
setmetatable(TestScreen, Screen)

function TestScreen:new()
    local o = Screen.new(TestScreen)
    o.world = World:new{
        battlefield=Battlefield:new(),
        player=Player:new(),
        renderer=Renderer:new()
    }
    return o
end

function TestScreen:load()
    self.world:add_entity{load_event={world=self.world}}
end

function TestScreen:draw()
    self.world:add_entity{draw_event={}}
end

function TestScreen:update(dt)
    self.world:add_entity{update_event={dt=dt}}
end

function TestScreen:keypressed(key)
    self.world:add_entity{key_event={pressed=true, key=key}}
end

function TestScreen:keyreleased(key)
    self.world:add_entity{key_event={pressed=false, key=key}}
end

return TestScreen
