Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage("Assets/Images/Pipe.png")
local PIPE_SCROLL = 60

function Pipe:init()
    self.x = virtual_width
    self.y = math.random(virtual_height / 4, virtual_height - 10)

    self.width = PIPE_IMAGE:getWidth()

end

function Pipe:update(dt)
    self.x = self.x - PIPE_SCROLL * dt
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end