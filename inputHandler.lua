
local inputHandler = {} 
game_debug = require "game_debug"

-- inputHandler.lua

function love.keypressed(key)
	local Party = require "party"
	if key == "right" then
		Party:changeDirection(1)
	end
	if key == "left" then
		Party:changeDirection(-1)
	end
	if key == "up" then
		Party:moveForward()
	end
	if key == "down" then
		Party:moveBackward()
	end
	if key == "p" then
		game_debug:switchDebug()
	end
end

return inputHandler
