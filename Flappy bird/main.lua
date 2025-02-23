_G.love = require ('love')
_G.push = require ('push')

local window_width, window_height, virtual_width, virtual_height = 1280, 720, 512, 288
local background = love.graphics.newImage("Assets/Images/background.png")
local ground = love.graphics.newImage("Assets/Images/ground.png")

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    love.window.setTitle("Flappy Bird")
    
    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    
end

function love.draw()
    push:start()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, virtual_height - 16)
    push:finish()
end