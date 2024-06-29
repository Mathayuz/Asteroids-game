local tempoEntreDisparos = 0.25
local tempoDesdeUltimoDisparo = 0

function love.load()
    love.window.setTitle("Asteroids PET")
    love.window.setMode(1000, 800)

    nave = {
        x = 500,
        y = 400,
        velocidade = 200,
        angulo = 0,
        balas = {}
    }

    asteroids = {}
    for i = 1, 8 do
        table.insert(asteroids, {
            x = math.random(0, 1000),
            y = math.random(0, 800),
            angulo = math.random(0, 2 * math.pi),
            velocidade = 100,
            raio = math.random(20, 40)
        })
    end
end

function love.update(dt)
    tempoDesdeUltimoDisparo = tempoDesdeUltimoDisparo + dt

    if love.keyboard.isDown("d") then
        nave.angulo = nave.angulo + 3 * dt
    elseif love.keyboard.isDown("a") then
        nave.angulo = nave.angulo - 3 * dt
    end

    if love.keyboard.isDown("w") then
        nave.x = nave.x + math.cos(nave.angulo) * nave.velocidade * dt
        nave.y = nave.y + math.sin(nave.angulo) * nave.velocidade * dt
    end

    if love.keyboard.isDown("space") and tempoDesdeUltimoDisparo >= tempoEntreDisparos then
        table.insert(nave.balas, {
            x = nave.x,
            y = nave.y,
            angulo = nave.angulo,
            velocidade = 500
        })
        tempoDesdeUltimoDisparo = 0
    end

    if nave.x < 0 then nave.x = 1000 elseif nave.x > 1000 then nave.x = 0 end
    if nave.y < 0 then nave.y = 800 elseif nave.y > 800 then nave.y = 0 end

    for i, bullet in ipairs(nave.balas) do
        bullet.x = bullet.x + math.cos(bullet.angulo) * bullet.velocidade * dt
        bullet.y = bullet.y + math.sin(bullet.angulo) * bullet.velocidade * dt
        if bullet.x < 0 or bullet.x > 1000 or bullet.y < 0 or bullet.y > 800 then
            table.remove(nave.balas, i)
        end
    end

    for _, asteroid in ipairs(asteroids) do
        asteroid.x = asteroid.x + math.cos(asteroid.angulo) * asteroid.velocidade * dt
        asteroid.y = asteroid.y + math.sin(asteroid.angulo) * asteroid.velocidade * dt

        if asteroid.x < 0 then asteroid.x = 1000 elseif asteroid.x > 1000 then asteroid.x = 0 end
        if asteroid.y < 0 then asteroid.y = 800 elseif asteroid.y > 800 then asteroid.y = 0 end
    end  
end

function love.draw()

    love.graphics.push()
    love.graphics.translate(nave.x, nave.y)
    love.graphics.rotate(nave.angulo)
    love.graphics.polygon("line", -10, 10, 10, 0, -10, -10, 0, 0)
    love.graphics.pop()


    for _, bullet in ipairs(nave.balas) do
        love.graphics.circle("fill", bullet.x, bullet.y, 2)
    end


    for _, asteroid in ipairs(asteroids) do
        love.graphics.circle("line", asteroid.x, asteroid.y, asteroid.raio)
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
