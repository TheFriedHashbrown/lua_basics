_G.love = require("love")

function love.load()
    love.graphics.setBackgroundColor(0.5, 0.5, 1)

    _G.pacman = {}
    pacman.x = 200
    pacman.y = 250
    pacman.angle1 = 1
    pacman.angle2 = 5

    _G.food = {}
    food.x = 600
    food.eaten = false
end

function love.update(dt)
    if love.keyboard.isDown("down") then
        pacman.angle1 = pacman.angle1 + math.pi * dt
        pacman.angle2 = pacman.angle2 + math.pi * dt
    elseif love.keyboard.isDown("up") then
        pacman.angle1 = pacman.angle1 - math.pi * dt
        pacman.angle2 = pacman.angle2 - math.pi * dt
    end

    if love.keyboard.isDown("a") then
        pacman.x = pacman.x - 4
    elseif love.keyboard.isDown("d") then
        pacman.x = pacman.x + 4
    elseif love.keyboard.isDown("w") then
        pacman.y = pacman.y - 4
    elseif love.keyboard.isDown("s") then
        pacman.y = pacman.y + 4
    end

    if pacman.x >= food.x + 15 then
        food.eaten = true
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    if not food.eaten then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 600, 200, 70, 70)
    end

    love.graphics.setColor(1, 0.7, 0.1)
    love.graphics.arc("fill", pacman.x, pacman.y, 60, pacman.angle1, pacman.angle2)
    
end 