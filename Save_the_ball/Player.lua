Player = Class{}

function Player:init(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius
end

function Player:movement()
    self.x, self.y = love.mouse.getPosition()
end

function Player:render()
    love.graphics.circle('fill', self.x, self.y, self.radius)
end