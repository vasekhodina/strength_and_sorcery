
local inputHandler = {} 
game_debug = require "game_debug"

-- inputHandler.lua

function love.keypressed(key)
	local Party = require "Party"
	if key == "right" then
		party.changeDirection(1)
	end
	if key == "left" then
		party.changeDirection(-1)
	end
	if key == "up" then
		party.moveForward()
	end
	if key == "down" then
		party.moveBack()
	end
	if key == "p" then
		if game_debug.getDebug() == false then
			game_debug.setDebug(true)
		else 
			game_debug.setDebug(false)
		end
	end
end

return inputHandler
