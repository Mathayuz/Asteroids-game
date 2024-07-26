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
    -- Colisão entre Sonic e bordas
    if sonic.y < 0 or sonic.y + sonic.height > 700 then
        love.load()
    end
    -- Colisão entre Sonic e pipes
    for _, pipe in ipairs(pipes.pipes) do
        if sonic.x + sonic.width > pipe.x and
            sonic.x < pipe.x + pipe.width and
            (sonic.y < pipe.y or sonic.y + sonic.height > pipe.y + pipe.height) then
            love.load()
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    sonic:draw()
    pipes:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 700, 1200, 100)
end
