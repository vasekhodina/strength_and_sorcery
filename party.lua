-- party.lua
-- class containing necessary things about party

local party = {}

-- keeps party direction 0 - north, 1 - east, 2 - south, 3 - west 
map = require "map"
local direction = 0
local x = 17
local y = 6

function party.changeDirection(change)
	if change == 1 then direction = direction + 1
	elseif change == -1 then direction = direction - 1
	else print 'Wat! Invalid argument to party.changeDirection' 
	end
	party.correctDirection()
	print('Party direction: ' .. direction)
end

function party.correctDirection()
	if direction > 3 then direction = 0 end
	if direction < 0 then direction = 3 end
end

function party.setX(new_x)
	x = new_x	
end

function party.getX()
	return x
end

function party.setY(new_y)
	y = new_y
end

function party.getY()
	return y
end

function party.getDirection()
	return direction
end

function party.moveForward()
	if direction == 0 then
		if map.currentMap[y-1][x] == 0 then
			y = y - 1
		end
	elseif direction == 1 then
		if map.currentMap[y][x+1] == 0 then
			x = x + 1
		end
	elseif direction == 2 then
		if map.currentMap[y+1][x] == 0 then
			y = y + 1
		end
	elseif direction == 3 then
		if map.currentMap[y][x-1] == 0 then
			x = x - 1
		end
	else 
		print("Error in party orientation!")
	end
end

function party.moveBackward()

end
return party
