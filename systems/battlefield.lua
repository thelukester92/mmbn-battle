local System = require('systems.system')

local Battlefield = {}
Battlefield.__index = Battlefield
setmetatable(Battlefield, System)

function Battlefield:new(options)
    local o = System:new()
    setmetatable(o, self)
    options = options or {}

    o.entities_on_grid = {}
    o.grid_entities = {}
    o.init_config = options.init_config or {
        { 'red_top', 'red_top', 'red_top', 'blu_top', 'blu_top', 'blu_top' },
        { 'red_med', 'red_med', 'red_med', 'blu_med', 'blu_med', 'blu_med' },
        { 'red_btm', 'red_btm', 'red_btm', 'blu_btm', 'blu_btm', 'blu_btm' }
    }
    o.origin = {
        x=options.origin_x or 100,
        y=options.origin_y or 220
    }
    o.skip = { x=40, y=24 }

    return o
end

function Battlefield:entity_added(e)
    if e:has('grid_position') then
        table.insert(self.entities_on_grid, e)
    end

    if e:has('load_event') then
        self:load(e.load_event)
    end

    if e:has('update_event') then
        self:update(e.update_event)
    end

    if e:has('alter_grid_action') then
        self:alter_grid(e.alter_grid_action)
    end
end

function Battlefield:load(evt)
    for i, row in ipairs(self.init_config) do
        self.grid_entities[i] = {}
        for j, col in ipairs(row) do
            self.grid_entities[i][j] = evt.world:add_entity{
                color={color=col:sub(1, 3)},
                drawable={texture='battlefield', frame=col},
                grid_panel={x=j, y=i},
                position={
                    x = self.origin.x + (j-1)*self.skip.x,
                    y = self.origin.y + (i-1)*self.skip.y
                }
            }
        end
    end
end

function Battlefield:update(evt)
    for _, e in pairs(self.entities_on_grid) do
        e.position.x = self.origin.x + self.skip.x * (e.grid_position.x - 1) + e.grid_position.offset_x
        e.position.y = self.origin.y + self.skip.y * (e.grid_position.y - 1) + e.grid_position.offset_y
    end
end

function Battlefield:alter_grid(evt)
    local positions = {'_top', '_med', '_btm'}
    self.grid_entities[evt.y][evt.x].color.color = evt.color
    self.grid_entities[evt.y][evt.x].drawable.frame = evt.color .. positions[evt.y]
end

return Battlefield
