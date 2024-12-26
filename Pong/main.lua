_G.push = require("push")
_G.love = require("love")
local window_width, window_height = 1280, 720
-- 432, 233
local virtual_height, virtual_width = 233, 432
local paddle_speed = 175


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    _G.player1score = 0
    _G.player2score = 0

    _G.player1y = 30
    _G.player2y = virtual_height - 50
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1y = player1y - paddle_speed*dt
    elseif love.keyboard.isDown('s') then
        player1y = player1y + paddle_speed*dt
    end

    if love.keyboard.isDown('up') then
        player2y = player2y - paddle_speed*dt
    elseif love.keyboard.isDown('down') then
        player2y = player2y + paddle_speed*dt
    end

end

function love.draw()
    push:apply('start')

    love.graphics.setBackgroundColor(40, 45, 52, 255)
    -- love.graphics
    love.graphics.rectangle('fill', 10, player1y, 5, 20)

    love.graphics.rectangle('fill', virtual_width - 10, player2y, 5, 20)
    love.graphics.rectangle('fill', (virtual_width/2) - 2, (virtual_height/2) - 2, 4, 4)

    push:apply('end')
end