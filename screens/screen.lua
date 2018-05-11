local Screen = {}
Screen.__index = Screen

function Screen:new()
    local o = {}
    setmetatable(o, self)
    return o
end

function Screen:load()
end

function Screen:draw()
end

function Screen:update(dt)
end

function Screen:mousepressed(x, y, button, istouch)
end

function Screen:mousereleased(x, y, button, istouch)
end

function Screen:keypressed(key)
end

function Screen:keyreleased(key)
end

function Screen:focus(f)
end

function Screen:quit()
end

return Screen
