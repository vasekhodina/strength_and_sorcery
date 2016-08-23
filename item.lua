-- Item.lua
-- Class for items and all the operations with them
local Item = {}

--initialize variables
local self.sprite = nil
local self.icon = nil

function Item:new(x, y, sprite_path)
	self.x = x
	self.y = y
	self.sprite = love.graphics.NewImage(sprite_path) 
	self.icon = love.graphics.NewImage(icon_path)
end

function Item:draw()
	love.graphics.draw(x,y)
end

return Item
