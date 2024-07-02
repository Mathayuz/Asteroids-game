local Nave = {}
Nave.__index = Nave

function Nave.new()
    local self = {}

    self.x = 400
    self.y = 300
    self.angle = 0
    self.speed = 0
    self.radius = 10

    return self
end

function Nave.update()
    if love.keyboard.isDown("d") then
        Nave.angulo = Nave.angulo + 3
    elseif love.keyboard.isDown("a") then
        Nave.angulo = Nave.angulo - 3
    end

    if love.keyboard.isDown("w") then
        Nave.x = Nave.x + math.cos(Nave.angulo) * Nave.velocidade * dt
        Nave.y = Nave.y + math.sin(Nave.angulo) * Nave.velocidade * dt
    end

    if Nave.x < 0 then Nave.x = 800 elseif Nave.x > 800 then Nave.x = 0 end
    if Nave.y < 0 then Nave.y = 600 elseif Nave.y > 600 then Nave.y = 0 end
end

function Nave.draw()
    love.graphics.polygon("line", -10, 10, 10, 0, -10, -10, 0, 0)
end
