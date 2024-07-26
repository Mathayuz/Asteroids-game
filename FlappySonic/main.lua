-- Flappy Sonic Game!!

local Sonic = require("sonic")

function love.load()
    sonic = Sonic.new()
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
end

function love.update(dt)
    sonic:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    sonic:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 700, 1200, 100)
end