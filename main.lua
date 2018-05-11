local TestScreen = require('screens.test')
local screen

function love.load()
    screen = TestScreen:new()
    screen:load()
end

function love.draw()
    screen:draw()
end

function love.update(dt)
    screen:update(dt)
end

function love.mousepressed(x, y, button, istouch)
    screen:mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    screen:mousereleased(x, y, button, istouch)
end

function love.keypressed(key)
    screen:keypressed(key)
end

function love.keyreleased(key)
    screen:keyreleased(key)
end

function love.focus(f)
    screen:focus(f)
end

function love.quit()
    screen:quit()
end
