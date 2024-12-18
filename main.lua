_G.love = require("love")

function love.load()
    love.graphics.setBackgroundColor(0.5, 0.5, 1)

    _G.pacman = {}
    pacman.x = 200
    pacman.y = 250

    _G.food = {}
    food.x = 600
    food.eaten = false
end

function love.update(dt)
    pacman.x = pacman.x + 1

    if pacman.x >= food.x + 15 then
        food.eaten = true
    end
end

function love.draw()
    if not food.eaten then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 600, 200, 70, 70)
    end

    love.graphics.setColor(1, 0.7, 0.1)
    love.graphics.arc("fill", pacman.x, pacman.y, 60, 1, 5)
    
end 