local game_debug = {}

party = require "party"

local map_name = ""

local debug_text = "Map name: " .. map_name .. "\n" ..
				   "Party location, X: " .. party.getX() .. ", Y: " .. party.getY() .. "\n"  ..
				   "Party direction: " .. party.getDirection()
local debug_bool = false

function game_debug.print_message()
	if debug_bool == true then
		love.graphics.print(debug_text,20,20)
	end
end

function game_debug.setDebug(debug_var)
	debug_bool=debug_var
	print("Debug mode enabled!")
end

function game_debug.getDebug()
	print("Debug mode disabled!")
	return debug_bool
end
return game_debug
