local System = require('systems.system')

local Player = {}
Player.__index = Player
setmetatable(Player, System)

function Player:entity_added(e)
    if e:has('load_event') then
        self:load(e.load_event)
    end

    if e:has('key_event') then
        self:key(e.key_event)
    end

    if e:has('anim_ended_event') then
        self:anim_ended(e.anim_ended_event)
    end
end

function Player:load(evt)
    self.player = evt.world:add_entity{
        drawable={texture='player', frame='idle', zIndex=1},
        grid_position={x=1, y=1, offset_x=3, offset_y=-24},
        position={x=0, y=0}
    }
end

function Player:key(evt)
    if evt.pressed and not self.busy and (evt.key == 'up' or evt.key == 'down' or evt.key == 'left' or evt.key == 'right') then
        self.player.drawable.anim = 'move_start'
        self.key_pressed = evt.key
        self.busy = true
    end
end

function Player:anim_ended(evt)
    if evt.entity == self.player then
        if evt.anim == 'move_start' then
            self:complete_move()
        end
        if evt.anim == 'move_end' then
            self.player.drawable.frame = 'idle'
            self.busy = false
        end
    end
end

function Player:complete_move()
    self.player.drawable.anim = 'move_end'

    local key = self.key_pressed
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
