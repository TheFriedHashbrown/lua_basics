push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'
require 'StateMachine'
require 'states.BaseState'
require 'states.CountdownState'
require 'states.PlayState'
require 'states.ScoreState'
require 'states.TitleScreenState'

_G.window_width = 1280
_G.window_height = 720
_G.virtual_width = 512
_G.virtual_height = 288

local background = love.graphics.newImage('Assets/Images/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('Assets/Images/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413
local GROUND_LOOPING_POINT = 514

local scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Fifty Bird')

    smallFont = love.graphics.newFont(8)
    mediumFont = love.graphics.newFont(14)
    flappyFont = love.graphics.newFont(28)
    hugeFont = love.graphics.newFont(56)
    love.graphics.setFont(flappyFont)

    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    sounds = {
        ['jump'] = love.audio.newSource("Assets/Audio/Flap.wav", 'static'),
        ['hurt'] = love.audio.newSource("Assets/Audio/Hurt.wav", 'static'),
        ['score'] = love.audio.newSource("Assets/Audio/score.wav", 'static')
    }

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

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
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % 
        BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, virtual_height - 16)
    
    push:finish()
end