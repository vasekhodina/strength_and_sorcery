-- Item.lua
-- Class for items and all the operations with them
local WorldItem = {}

--initialize variables
local self.x = 0
local self.y = 0
local self.sprite = 0
local self.in_inventory = false

function WorldItem:new(x, y, sprite_path)
	self.x = x
	self.y = y
	self.sprite = love.graphics.NewImage(sprite_path) 
end

function WorldItem:draw(SCALE)
	love.graphics.draw(200,200,0,SCALE)
end

return Item
