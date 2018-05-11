local Drawable = require('components.drawable')
local Position = require('components.position')

local ComponentFactory = {}
ComponentFactory.__index = ComponentFactory

function ComponentFactory:newComponent(type, props)
    if type == 'drawable' then
        return Drawable:new(props)
    elseif type == 'position' then
        return Position:new(props)
    else
        error('invalid component type: ' .. type)
    end
end

return ComponentFactory
