local game_debug = {}

Party = require "Party"
Gui = require "Gui"

local map_name = ""

local debug_text = "" 
local debug_bool = false
local party = 0
local worldScreen = 0

function game_debug:new(newParty,newWorldScreen)
	party = newParty
	worldScreen = worldScreen
end

function game_debug:prepareDebugText(debug_party)
	love.graphics.setFont(Gui.font)
	debug_text = "Map name: " .. map_name .. "\n" ..
							 "Party location, X: " .. debug_party:getX() .. ", Y: " .. debug_party:getY() .. "\n"  ..
							 "Party direction: " .. debug_party:getDirection()
end

function game_debug:print_message()
	love.graphics.setFont(Gui.font)
	game_debug:prepareDebugText(party)
	if debug_bool == true then
		love.graphics.print(debug_text,20,20)
		love.graphics.print(viewMatrix[4][1] .. viewMatrix[4][2] .. viewMatrix[4][3],20,70)
		love.graphics.print(viewMatrix[3][1] .. viewMatrix[3][2] .. viewMatrix[3][3],20,80)
		love.graphics.print(viewMatrix[2][1] .. viewMatrix[2][2] .. viewMatrix[2][3],20,90)
		love.graphics.print(viewMatrix[1][1] .. viewMatrix[1][2] .. viewMatrix[1][3],20,100)
	end
end

function game_debug:switchDebug()
	if debug_bool == false then
		debug_bool = true
	love.graphics.setFont(Gui.font)
		print("Info: Debug mode enabled!")
	else 
		debug_bool = false 
	love.graphics.setFont(Gui.font)
		print("Info: Debug mode disabled!")
	end
end

function game_debug:getDebug()
	return debug_bool
end

return game_debug
