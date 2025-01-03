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
    _G.servingPlayer = 1
    _G.winningPlayer = 1

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
            gameState = "serve"
        elseif gameState == "serve" then
            gameState = "play"
        end
    end
end


function love.update(dt)
    if gameState == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer== 1 then
            ball.dx = math.random (140,200)
        else 
            ball.dx = -math.random(140, 200)
        end
    elseif gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.1
            ball.x = player1.x + player1.width --change this to width to see the difference

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
    

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.1
            ball.x = player2.x - ball.width --change this to width to see the difference

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= virtual_height - ball.height then
            ball.y = virtual_height - ball.height
            ball.dy = -ball.dy
        end
        ball:update(dt)
    end

    if ball.x < 0 then
        servingPlayer = 1
        player2score = player2score + 1

        gameState = 'serve'
        ball:reset()
    end

    if ball.x > virtual_width then
        servingPlayer = 2
        player1score = player1score + 1
    
        gameState = 'serve'
        ball:reset()
    end

    --player1 movement
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
    -- displayFPS()

    push:apply('end')
end

-- function displayFPS()
--     love.graphics.setFont(score_font)
--     love.graphics.setColor(0, 255, 0, 255)
--     love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
-- end