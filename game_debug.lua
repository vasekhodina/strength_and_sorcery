local game_debug = {}

Party = require "Party"
Gui = require "Gui"
conf = require "conf"

local map_name = ""

local debug_text = "" 
local is_debug= false
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
	love.graphics.push()
	love.graphics.scale(0.25)
	love.graphics.setFont(Gui.font)
	game_debug:prepareDebugText(party)
	if is_debug == true then
		love.graphics.print(debug_text,20,20)
		for i=5,1,-1 do
			love.graphics.print(table.concat(viewMatrix[i]),20,120-(i*10))
		end
	end
	love.graphics.pop()
end

function game_debug:switchDebug()
	if is_debug == false then
		is_debug = true
		love.graphics.setFont(Gui.font)
		print("Info: Debug mode enabled!")
	else 
		is_debug = false 
		love.graphics.setFont(Gui.font)
		print("Info: Debug mode disabled!")
	end
end

return game_debug
