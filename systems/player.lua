local Entity = require('entity')
local System = require('systems.system')

local Player = {}
Player.__index = Player
setmetatable(Player, System)

function Player:entityAdded(e)
    if e:has('load_event') then
        self:load(e.load_event.world)
    end

    if e:has('key_event') then
        if e.key_event.pressed then
            self:keypressed(e.key_event.key)
        end
    end

    if e:has('anim_ended_event') and e.anim_ended_event.entity == self.player then
        if e.anim_ended_event.anim == 'move_start' then
            self:complete_move()
        end
        if e.anim_ended_event.anim == 'move_end' then
            self.player.drawable.frame = 'idle'
            self.busy = false
        end
    end
end

function Player:load(world)
    self.player = Entity:new{
        drawable={texture='player', frame='idle', zIndex=1},
        grid_position={x=1, y=1, offset_x=3, offset_y=-24},
        position={x=0, y=0}
    }
    world:addEntity(self.player)
end

function Player:keypressed(key)
    if not self.busy and (key == 'up' or key == 'down' or key == 'left' or key == 'right') then
        self.player.drawable.anim = 'move_start'
        self.player.drawable.anim_counter = 1
        self.player.drawable.frame_counter = 1
        self.key = key
        self.busy = true
    end
end

function Player:complete_move()
    self.player.drawable.anim = 'move_end'
    self.player.drawable.anim_counter = 1
    self.player.drawable.frame_counter = 1

    local key = self.key
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
