local Entity = require('entity')
local System = require('systems.system')

local Player = {}
Player.__index = Player
setmetatable(Player, System)

function Player:load(world)
    self.player = Entity:new{
        drawable={texture='player', frame='idle', zIndex=1},
        grid_position={x=1, y=1, offset_x=3, offset_y=-24},
        position={x=0, y=0}
    }
    world:addEntity(self.player)
end

function Player:keypressed(key)
    if key == 'up' then
        self.player.grid_position.y = self.player.grid_position.y - 1
    elseif key == 'down' then
        self.player.grid_position.y = self.player.grid_position.y + 1
    elseif key == 'left' then
        self.player.grid_position.x = self.player.grid_position.x - 1
    elseif key == 'right' then
        self.player.grid_position.x = self.player.grid_position.x + 1
    end
end

return Player
