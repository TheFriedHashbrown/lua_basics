Class = require 'class'

require 'Paddle'
require 'Ball'

_G.push = require("push")
_G.love = require("love")
local window_width, window_height = 1280, 720
-- 432, 233
local virtual_height, virtual_width = 233, 432
local paddle_speed = 175


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')
    _G.score_font = love.graphics.newFont(16)

    math.randomseed(os.time())

    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    _G.player1score = 0
    _G.player2score = 0

    _G.player1 = Paddle(10, 30, 5, 20, virtual_width, virtual_height)
    _G.player2 = Paddle(virtual_width - 10, virtual_height - 30, 5, 20, virtual_width, virtual_height)

    _G.ball = Ball(virtual_width/2 - 2, virtual_height/2 - 2, 4, 4, virtual_width, virtual_height)

    _G.gameState = 'start'
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        --the enter key starts or stops the game 
        if gameState == "start" then
            gameState = "play"
        else 
            gameState = "start"

            ball:reset()
        end
    end
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.dy = -paddle_speed
    elseif love.keyboard.isDown('s') then
        player1.dy = paddle_speed
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -paddle_speed
    elseif love.keyboard.isDown('down') then
        player2.dy = paddle_speed
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)

end

function love.draw()
    push:apply('start')

    love.graphics.setFont(score_font)
    if gameState == "play" then
        love.graphics.printf("In play", 0, 20, virtual_width, 'center')
    else
        love.graphics.printf("Start state", 0, 20, virtual_width, 'center')
    end

    love.graphics.print(tostring(player1score), virtual_width/2 - 50, virtual_height/3)
    love.graphics.print(tostring(player2score), virtual_width/2 + 50, virtual_height/3)

    love.graphics.setBackgroundColor(40, 45, 52, 255)
    
    --paddle for player1
    player1:render()
    --paddle for player2
    player2:render()
 
    ball:render()
    displayFPS()

    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(score_font)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end