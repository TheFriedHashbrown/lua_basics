-- require 'Paddle'
Ball = Class{}

function Ball:init(x, y, width, height, virtual_width, virtual_height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.virtual_width = virtual_width
    self.virtual_height = virtual_height

    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = self.virtual_width/2 - 2
    self.y = self.virtual_height/2 - 2
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt
end

function Ball:collides(paddle)
    if self.x  > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    return true
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end