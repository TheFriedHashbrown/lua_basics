_G.push = require("push")
_G.love = require("love")
local window_width, window_height = 1280, 720
-- 432, 233
local virtual_height, virtual_width = 233, 432
local paddle_speed = 175


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    _G.score_font = love.graphics.newFont(32)

    math.randomseed(os.time())

    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    _G.player1score = 0
    _G.player2score = 0

    _G.player1y = 30
    _G.player2y = virtual_height - 50

    _G.ballx = virtual_width/2 - 2
    _G.bally = virtual_height/2 - 2
    _G.balldx = math.random(2) == 1 and 100 or -100
    _G.balldy = math.random(-50, 50)

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

            --start the ball by putting it back into the middle position
            ballx = virtual_width/2 - 2
            bally = virtual_height/2 - 2
            
            --randomizing the ball's initial velocity again
            balldx = math.random(2) == 1 and 100 or -100
            balldy = math.random(-50, 50)
        end
    end
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1y = math.max(0, player1y - paddle_speed*dt)
    elseif love.keyboard.isDown('s') then
        player1y = math.min(virtual_height-20, player1y + paddle_speed*dt)
    end

    if love.keyboard.isDown('up') then
        player2y = math.max(0, player2y - paddle_speed*dt)
    elseif love.keyboard.isDown('down') then
        player2y = math.min(virtual_height-20, player2y + paddle_speed*dt)
    end

    if gameState == 'play' then
        ballx = ballx + balldx*dt
        bally = bally + balldy*dt
    end
end

function love.draw()
    push:apply('start')

    love.graphics.setFont(score_font)
    love.graphics.print(tostring(player1score), virtual_width/2 - 50, virtual_height/3)
    love.graphics.print(tostring(player2score), virtual_width/2 + 50, virtual_height/3)

    love.graphics.setBackgroundColor(40, 45, 52, 255)
    
    --paddle for player1
    love.graphics.rectangle('fill', 10, player1y, 5, 20)
    --paddle for player2
    love.graphics.rectangle('fill', virtual_width - 10, player2y, 5, 20)
    --ball 
    love.graphics.rectangle('fill', ballx, bally, 4, 4)

    push:apply('end')
end