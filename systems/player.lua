local System = require('systems.system')

local Player = {}
Player.__index = Player
setmetatable(Player, System)

function Player:new()
    local o = System:new()
    setmetatable(o, self)
    o.grid_entities = {}
    return o
end

function Player:entity_added(e)
    if e:has('grid_panel') then
        local gp = e.grid_panel
        self.grid_entities[gp.y] = self.grid_entities[gp.y] or {}
        self.grid_entities[gp.y][gp.x] = e
    end

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
    self.world = evt.world
    self.player = evt.world:add_entity{
        color={color='red'},
        drawable={texture='player', frame='idle', zIndex=1},
        grid_position={x=1, y=1, offset_x=3, offset_y=-24},
        position={x=0, y=0}
    }
end

function Player:key(evt)
    if evt.pressed and not self.busy then
        if self:valid_move(evt.key) then
            self.player.drawable.anim = 'move_start'
            self.key_pressed = evt.key
            self.busy = true
        elseif evt.key == 'z' then
            self.player.drawable.frame = 'shoot'
            -- self.busy = true
        elseif evt.key == 'x' then
            if self.grid_entities[1][self.player.grid_position.x+1] ~= nil then
                self.world:add_entity{alter_grid_action={
                    x=self.player.grid_position.x+1,
                    y=self.player.grid_position.y,
                    color='red'
                }}
            end
        end
    end
end

function Player:anim_ended(evt)
    if evt.entity == self.player then
        if evt.anim == 'move_start' then
            self.player.drawable.anim = 'move_end'
            self:complete_move()
        end
        if evt.anim == 'move_end' then
            self.player.drawable.frame = 'idle'
            self.busy = false
        end
    end
end

function Player:valid_move(key)
    local color = self.player.color.color
    local grid = self.grid_entities
    local gp = self.player.grid_position
    local y, x = gp.y, gp.x

    if key == 'up' then
        y = y - 1
    elseif key == 'down' then
        y = y + 1
    elseif key == 'left' then
        x = x - 1
    elseif key == 'right' then
        x = x + 1
    else
        return false
    end

    return self.grid_entities[y] ~= nil
        and self.grid_entities[y][x] ~= nil
        and self.grid_entities[y][x].color.color == color
end

function Player:complete_move()
    if self.key_pressed == 'up' then
        self.player.grid_position.y = self.player.grid_position.y - 1
    elseif self.key_pressed == 'down' then
        self.player.grid_position.y = self.player.grid_position.y + 1
    elseif self.key_pressed == 'left' then
        self.player.grid_position.x = self.player.grid_position.x - 1
    elseif self.key_pressed == 'right' then
        self.player.grid_position.x = self.player.grid_position.x + 1
    end
end

return Player
