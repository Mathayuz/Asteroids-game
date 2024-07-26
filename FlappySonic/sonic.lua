-- Cria o e controla o Sonic

local Pipes = require("pipes")

local Sonic = {}
Sonic.__index = Sonic

function Sonic.new()
    local self = setmetatable({}, Sonic)
    self.x = 200
    self.y = 300
    self.width = 45
    self.height = 45
    self.velocidade = 0
    self.pontuacao = 0
    self.pontuou = false
    self.gravidade = 400
    self.image = love.graphics.newImage("sonic_52x53.png")
    return self
end

function Sonic:update(dt)
    self.velocidade = self.velocidade + self.gravidade * dt
    self.y = self.y + self.velocidade * dt    
end

function Sonic:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function love.keypressed(key)
    if key == "space" then
        sonic.velocidade = -200
    end
end

return Sonic