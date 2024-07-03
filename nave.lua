local Nave = {}
Nave.__index = Nave

function Nave.new()
    local self = setmetatable({}, Nave)
    self.x = 500
    self.y = 400
    self.raio = 10
    self.angulo = 0
    self.velocidade = 200
    self.balas = {}
    return self
end

function Nave:update(dt)

    -- Movimentação da nave
    if love.keyboard.isDown("w") then
        self.x = self.x + math.cos(self.angulo) * self.velocidade * dt
        self.y = self.y + math.sin(self.angulo) * self.velocidade * dt
    end
    if love.keyboard.isDown("a") then
        self.angulo = self.angulo - math.pi * dt
    end
    if love.keyboard.isDown("d") then
        self.angulo = self.angulo + math.pi * dt
    end

    if self.x < 0 then self.x = 1000 elseif self.x > 1000 then self.x = 0 end
    if self.y < 0 then self.y = 800 elseif self.y > 800 then self.y = 0 end

    -- Movimentação das balas
    for i = #self.balas, 1, -1 do
        local bala = self.balas[i]
        bala.x = bala.x + math.cos(bala.angulo) * bala.velocidade * dt
        bala.y = bala.y + math.sin(bala.angulo) * bala.velocidade * dt

        if bala.x < 0 or bala.x > 1000 or bala.y < 0 or bala.y > 800 then
            table.remove(self.balas, i)
        end
    end
end

function Nave:draw()
    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.angulo)
    love.graphics.polygon("line", -10, 10, 10, 0, -10, -10, 0, 0)
    love.graphics.pop()

    for _, bala in ipairs(self.balas) do
        love.graphics.circle("fill", bala.x, bala.y, 2)
    end
end

function love.keypressed(key)
    if key == "space" then
        table.insert(nave.balas, {
            x = nave.x,
            y = nave.y,
            angulo = nave.angulo,
            velocidade = 500
        })
    end
end

return Nave
