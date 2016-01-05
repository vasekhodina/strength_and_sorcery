local game_debug = {}

Party = require "Party"

local map_name = ""

local debug_text = "" 
local debug_bool = false

function game_debug:newDebug(newParty)
	party = newParty
end

--TODO include map into this function
function game_debug:prepareDebugText(party)
	debug_text = "Map name: " .. map_name .. "\n" ..
							 "Party location, X: " .. Party.getX() .. ", Y: " .. party.getY() .. "\n"  ..
							 "Party direction: " .. Party.getDirection()
end

function game_debug:print_message()
	if debug_bool == true then
		love.graphics.print(debug_text,20,20)
	end
end

function game_debug:setDebug(debug_var)
	debug_bool=debug_var
	print("Debug mode enabled!")
end

function game_debug:getDebug()
	print("Debug mode disabled!")
	return debug_bool
end
return game_debug
