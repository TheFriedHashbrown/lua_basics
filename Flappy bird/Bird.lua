Bird = Class{}

function Bird:init()
    self.image = love.graphics.newImage("Assets/Images/bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.dy = 0

    self.x = (virtual_width /2) - (self.width/2)
    self.y = (virtual_height /2) - (self.height/2)
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') then
        self.dy = -3.75
    end

    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end