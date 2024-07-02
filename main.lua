local Asteroid = require("asteroids")
local Nave = require("nave")

local tempoEntreDisparos = 0.25
local tempoDesdeUltimoDisparo = 0


function love.load()
    Nave = Nave.new()
    Asteroids = {}
    for i = 1, 10 do
        table.insert(Asteroids, Asteroid.new())
    end
end

function love.update(dt)
    tempoDesdeUltimoDisparo = tempoDesdeUltimoDisparo + dt

    if love.keyboard.isDown("d") then
        Nave.angulo = Nave.angulo + 3 * dt
    elseif love.keyboard.isDown("a") then
        Nave.angulo = Nave.angulo - 3 * dt
    end

    if love.keyboard.isDown("w") then
        Nave.x = Nave.x + math.cos(Nave.angulo) * Nave.velocidade * dt
        Nave.y = Nave.y + math.sin(Nave.angulo) * Nave.velocidade * dt
    end

    if love.keyboard.isDown("space") and tempoDesdeUltimoDisparo >= tempoEntreDisparos then
        table.insert(Nave.balas, {
            x = Nave.x,
            y = Nave.y,
            angulo = Nave.angulo,
            velocidade = 500
        })
        tempoDesdeUltimoDisparo = 0
    end

    if Nave.x < 0 then Nave.x = 1000 elseif Nave.x > 1000 then Nave.x = 0 end
    if Nave.y < 0 then Nave.y = 800 elseif Nave.y > 800 then Nave.y = 0 end

    for i, bala in ipairs(Nave.balas) do
        bala.x = bala.x + math.cos(bala.angulo) * bala.velocidade * dt
        bala.y = bala.y + math.sin(bala.angulo) * bala.velocidade * dt
        if bala.x < 0 or bala.x > 1000 or bala.y < 0 or bala.y > 800 then
            table.remove(Nave.balas, i)
        end
    end

    for _, asteroid in ipairs(Asteroids) do
        asteroid.x = asteroid.x + math.cos(asteroid.angulo) * asteroid.velocidade * dt
        asteroid.y = asteroid.y + math.sin(asteroid.angulo) * asteroid.velocidade * dt

        if asteroid.x < 0 then asteroid.x = 1000 elseif asteroid.x > 1000 then asteroid.x = 0 end
        if asteroid.y < 0 then asteroid.y = 800 elseif asteroid.y > 800 then asteroid.y = 0 end
    end

    for i, bala in ipairs(Nave.balas) do
        for j, asteroid in ipairs(Asteroids) do
            if math.sqrt((bala.x - asteroid.x) ^ 2 + (bala.y - asteroid.y) ^ 2) < asteroid.raio then
                table.remove(Nave.balas, i)
                if asteroid.raio > 35 then
                    table.remove(Asteroids, j)
                    table.insert(Asteroids, {
                        x = asteroid.x,
                        y = asteroid.y,
                        angulo = math.random(0, 2 * math.pi),
                        velocidade = 100,
                        raio = asteroid.raio / 2
                    })
                    table.insert(Asteroids, {
                        x = asteroid.x,
                        y = asteroid.y,
                        angulo = math.random(0, 2 * math.pi),
                        velocidade = 100,
                        raio = asteroid.raio / 2
                    })
                else
                    table.remove(Asteroids, j)
                end
            end
        end
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.translate(Nave.x, Nave.y)
    love.graphics.rotate(Nave.angulo)
    love.graphics.polygon("line", -10, 10, 10, 0, -10, -10, 0, 0)
    love.graphics.pop()


    for _, bala in ipairs(Nave.balas) do
        love.graphics.circle("fill", bala.x, bala.y, 2)
    end


    for _, asteroid in ipairs(Asteroids) do
        love.graphics.circle("line", asteroid.x, asteroid.y, asteroid.raio)
    end
end

function love.keypressed(key)
    if key == "space" then
        table.insert(Nave.balas, {
            x = Nave.x,
            y = Nave.y,
            angulo = Nave.angulo,
            velocidade = 500
        })
    end
end
