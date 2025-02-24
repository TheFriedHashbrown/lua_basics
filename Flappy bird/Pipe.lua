Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage("Assets/Images/Pipe.png")
_G.PIPE_SPEED = 60

_G.PIPE_HEIGHT = 288
_G.PIPE_WIDTH = 70

function Pipe:init(orientation, y)
    self.x = virtual_width
    self.y = y

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_HEIGHT

    self.orientation = orientation
end

function Pipe:update(dt)
    self.x = self.x - PIPE_SPEED * dt
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x,
    (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
    0, 1, self.orientation == 'top' and -1 or 1)
end