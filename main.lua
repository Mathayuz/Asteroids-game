-- Asteroids Game!!

local Asteroid = require("asteroid")
local Nave = require("nave")

function love.load()
    nave = Nave.new()
    asteroids = {}
    for i = 1, 20 do
        table.insert(asteroids, Asteroid.new())
    end
end

local vida = 3
local pontos = 0

function love.update(dt)
    nave:update(dt)
    for _, asteroid in ipairs(asteroids) do
        asteroid:update(dt)
    end

    -- Colisao entre nave e asteroid
    for i = #asteroids, 1, -1 do
        local asteroid = asteroids[i]
        if math.sqrt((nave.x - asteroid.x) ^ 2 + (nave.y - asteroid.y) ^ 2) < nave.raio + asteroid.radius then
            nave = Nave.new()
            vida = vida - 1
            table.remove(asteroids, i)
            if asteroid.radius > 20 then
                table.insert(asteroids, Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
                table.insert(asteroids, Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
            end
        end
    end

    if vida == 0 then
        love.update(dt)
        vida = 3
        pontos = 0
    end

    -- Colisao entre bala e asteroid
    for i = #nave.balas, 1, -1 do
        local bala = nave.balas[i]
        for j = #asteroids, 1, -1 do
            local asteroid = asteroids[j]
            if math.sqrt((bala.x - asteroid.x) ^ 2 + (bala.y - asteroid.y) ^ 2) < asteroid.radius then
                table.remove(nave.balas, i)
                table.remove(asteroids, j)
                if asteroid.radius > 35 then
                    table.insert(asteroids,
                        Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
                    table.insert(asteroids,
                        Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
                    pontos = pontos + 500
                elseif asteroid.radius > 25 and asteroid.radius <= 35 then
                    table.insert(asteroids,
                        Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
                    table.insert(asteroids,
                        Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
                    pontos = pontos + 250
                elseif asteroid.radius > 20 and asteroid.radius <= 25 then
                    table.insert(asteroids,
                        Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
                    table.insert(asteroids,
                        Asteroid.new({ x = asteroid.x, y = asteroid.y, radius = asteroid.radius / 2 }))
                    pontos = pontos + 100
                else
                    table.remove(asteroids, j)
                    pontos = pontos + 50
                end
                break
            end
        end
    end
end

local minhaFonte = love.graphics.newFont(30)

function love.draw()
    nave:draw()
    for _, asteroid in ipairs(asteroids) do
        asteroid:draw()
    end
    love.graphics.setFont(minhaFonte)
    love.graphics.print("Score: " .. pontos, 10, 10)
    love.graphics.print("Life: " .. vida, 10, 40)
end
