Bird = Class{}

function Bird:init(virtual_width, virtual_height)
    self.image = love.graphics.newImage("Assets/Images/bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.virtual_width = virtual_width
    self.virtual_height = virtual_height

    self.x = (virtual_width /2) - (self.width/2)
    self.y = (virtual_height /2) - (self.height/2)
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end