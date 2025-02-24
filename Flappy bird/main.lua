Class = require('class')
require 'Bird'
require 'Pipe'
require 'PipePair'

_G.GRAVITY = 20

_G.love = require ('love')
_G.push = require ('push')

_G.window_width, _G.window_height, _G.virtual_width, _G.virtual_height = 1280, 720, 512, 288

local background = love.graphics.newImage("Assets/Images/background.png")
local backgroundscroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 433

local ground = love.graphics.newImage("Assets/Images/ground.png")
local groundscroll = 0
local GROUND_SCROLL_SPEED = 60


local bird = Bird()
local pipePairs = {}
local spawnTimer = 0
local lastY = -PIPE_HEIGHT + math.random(80) + 20

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    love.window.setTitle("Flappy Bird")
    
    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
    
end

function love.update(dt)
    backgroundscroll = (backgroundscroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    groundscroll = (groundscroll + GROUND_SCROLL_SPEED * dt)
        % virtual_width    
    
    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
    local y = math.max(-PIPE_HEIGHT + 10,
        math.min(lastY + math.random(-20, 20), virtual_height - 90 - PIPE_HEIGHT))

    lastY = y
        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end

    bird:update(dt)
    
    for k, pair in pairs(pipePairs) do
        pair:update(dt)
    end

    for k, pair in pairs(pipePairs) do
        if pair.remove then
            table.remove(pipePairs, k)
        end
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundscroll, 0)
    
    for k, pipe in pairs(pipePairs) do
        pipe:render()
    end
    
    love.graphics.draw(ground, -groundscroll, virtual_height - 16)
    bird:render()

    push:finish()
end