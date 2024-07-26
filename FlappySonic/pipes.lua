-- Cria e controla os pipes

local Pipes = {}
Pipes.__index = Pipes


function Pipes.new()
    local self = setmetatable({}, Pipes)
    self.pipes = {}
    self.timer = 0
    self.interval = 2.3
    return self
end

function Pipes:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.interval then
        self.timer = self.timer - self.interval
        local pipe = {
            x = WIDTH,
            width = 100,
            y = love.math.random(100, 250),
            height = love.math.random(100, 220)

        }
        table.insert(self.pipes, pipe)
    end
    for i, pipe in ipairs(self.pipes) do
        pipe.x = pipe.x - 150 * dt
        if pipe.x < -pipe.width then
            table.remove(self.pipes, i)
        end
    end
end

function Pipes:draw()
    for i, pipe in ipairs(self.pipes) do
        -- Faz a parte interna do pipe
        love.graphics.setColor(love.math.colorFromBytes(147, 250, 165))
        love.graphics.rectangle("fill", pipe.x, 0, pipe.width, pipe.y)
        love.graphics.rectangle("fill", pipe.x, pipe.y + pipe.height, pipe.width, HEIGHT - pipe.y - pipe.height)
        -- Faz o contorno do pipe
        love.graphics.setColor(love.math.colorFromBytes(0, 0, 0))
        love.graphics.rectangle("line", pipe.x, 0, pipe.width, pipe.y)
        love.graphics.rectangle("line", pipe.x, pipe.y + pipe.height, pipe.width, HEIGHT - pipe.y - pipe.height)
        -- Faz a boca do pipe
        love.graphics.setColor(love.math.colorFromBytes(147, 250, 165))
        love.graphics.rectangle("fill", pipe.x - 10, pipe.y - 20, pipe.width + 20, 20)
        love.graphics.rectangle("fill", pipe.x - 10, pipe.y + pipe.height, pipe.width + 20, 20)
        -- Faz o contorno da boca do pipe
        love.graphics.setColor(love.math.colorFromBytes(0, 0, 0))
        love.graphics.rectangle("line", pipe.x - 10, pipe.y - 20, pipe.width + 20, 20)
        love.graphics.rectangle("line", pipe.x - 10, pipe.y + pipe.height, pipe.width + 20, 20)
    end
end

return Pipes
