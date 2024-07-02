local Asteroid = {}
Asteroid.__index = Asteroid

function Asteroid.new()
    local self = {}

    self.x = math.random(1000, 800)
    self.y = math.random(1000, 800)
    self.angle = math.random(0, 2 * math.pi)
    self.speed = math.random(75, 150)
    self.radius = math.random(10, 40)

    return self
end

function Asteroid.update()
    Asteroid.x = Asteroid.x + math.cos(Asteroid.angle) * Asteroid.speed
    Asteroid.y = Asteroid.y + math.sin(Asteroid.angle) * Asteroid.speed

    if Asteroid.x < 0 then Asteroid.x = 1000 elseif Asteroid.x > 1000 then Asteroid.x = 0 end
    if Asteroid.y < 0 then Asteroid.y = 800 elseif Asteroid.y > 800 then Asteroid.y = 0 end
end

function Asteroid.draw()
    love.graphics.circle("line", Asteroid.x, Asteroid.y, Asteroid.radius)
end
