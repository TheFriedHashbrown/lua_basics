love = require("love")
push = require 'push'
Class = require 'class'
require 'Player'

function love.load()
    love.window.setTitle("Save the ball")

    -- push:setupScreen(800, 600, 1280, 720, {
    --     fullscreen = true,
    --     resizable = false,
    --     vsync = true
    -- })

    player = Player(30, 30, 20)
end

function love.update(dt)
    player:movement()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    -- push:start()
    player:render()
    -- push:finish()
end