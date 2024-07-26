local Pipes = {}
Pipes.__index = Pipes

function Pipes.new()
    local self = setmetatable({}, Pipes)
    self.pipes = {}
    self.timer = 0
    self.interval = 2
    return self
end

function Pipes:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.interval then
        self.timer = 0
        self.interval = math.random(1, 3)
        local pipe = {}
        pipe.x = 1200
        pipe.y = math.random(100, 600)
        pipe.width = 50
        pipe.height = 500
        table.insert(self.pipes, pipe)
    end
    for i, pipe in ipairs(self.pipes) do
        pipe.x = pipe.x - 200 * dt
        if pipe.x < -pipe.width then
            table.remove(self.pipes, i)
        end
    end
end

function Pipes:draw()
    for i, pipe in ipairs(self.pipes) do
        love.graphics.rectangle("fill", pipe.x, 0, pipe.width, pipe.y)
        love.graphics.rectangle("fill", pipe.x, pipe.y + pipe.height, pipe.width, 800 - pipe.y - pipe.height)
    end
end

return Pipes