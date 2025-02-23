Class = require('class')
require 'Bird'

_G.GRAVITY = 20

_G.love = require ('love')
_G.push = require ('push')

local window_width, window_height, virtual_width, virtual_height = 1280, 720, 512, 288

local background = love.graphics.newImage("Assets/Images/background.png")
local backgroundscroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 433

local ground = love.graphics.newImage("Assets/Images/ground.png")
local groundscroll = 0
local GROUND_SCROLL_SPEED = 60


local bird = Bird(virtual_width, virtual_height)

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
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

    bird:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundscroll, 0)
    love.graphics.draw(ground, -groundscroll, virtual_height - 16)
    bird:render()

    push:finish()
end