love = require("love")
push = require 'push'

function love.load()
    love.window.setTitle("Save the ball")
    push:setupScreen(800, 600, 1280, 720, {
        fullscreen = true,
        resizable = false,
        vsync = true
    })
end

function love.update(dt)

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:start()

    push:finish()
end