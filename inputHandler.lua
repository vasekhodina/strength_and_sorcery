
local inputHandler = {} 

-- inputHandler.lua

function love.keypressed(key)
	local party = require "party"
	if key == "right" then
		party.changeDirection(1)
	end
	if key == "left" then
		party.changeDirection(-1)
	end
	if key == "up" then
		party.moveForward()
	end
end

return inputHandler
