Paddle = Class{}

function Paddle:init(x, y, width, height, virtual_width, virtual_height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.virtual_width = virtual_width
    self.virtual_height = virtual_height

    self.dy = 0
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy*dt)
    else
        self.y = math.min(self.virtual_height - self.height, self.y + self.dy*dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end