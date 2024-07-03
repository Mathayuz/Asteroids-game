local Asteroid = {}
Asteroid.__index = Asteroid

function Asteroid.new(params)
    local self = setmetatable({}, Asteroid)
    self.x = params and params.x or math.random(0, 1000)
    self.y = params and params.y or math.random(0, 800)
    self.angle = params and params.angle or math.random() * 2 * math.pi
    self.speed = params and params.speed or math.random(50, 100)
    self.radius = params and params.radius or math.random(20, 50)
    return self
end

function Asteroid:update(dt)
    -- Movimentacaoo do asteroid
    self.x = self.x + math.cos(self.angle) * self.speed * dt
    self.y = self.y + math.sin(self.angle) * self.speed * dt

    if self.x < 0 then self.x = 1000 elseif self.x > 1000 then self.x = 0 end
    if self.y < 0 then self.y = 800 elseif self.y > 800 then self.y = 0 end
end

function Asteroid:draw()
    love.graphics.circle("line", self.x, self.y, self.radius)
end

return Asteroid
