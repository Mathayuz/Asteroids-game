-- Flappy Sonic Game!!

local Sonic = require("sonic")
local Pipes = require("pipes")

function love.load()
    sonic = Sonic.new()
    pipes = Pipes.new()
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
end

function love.update(dt)
    sonic:update(dt)
    pipes:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    sonic:draw()
    pipes:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 700, 1200, 100)
end
