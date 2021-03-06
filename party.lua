-- party.lua
-- class containing necessary things about party

local Party = {}

map = require "map"
-- keeps party direction 0 - north, 1 - east, 2 - south, 3 - west 
local direction = 0
local x = 0
local y = 0
local map = 0

--- Constructor of the party table ("class") 
-- @param newX map coordinates where the party should be spawn 
-- @param newY map coordinates where the party should be spawn 
-- @param newDirection direction of the new party
function Party:new(newX, newY, newDirection, newMap)
	x = newX
	y = newY
	direction = newDirection
	map = newMap
	print("Info: Creating new party, x:" .. newX .. " y: " .. newY .. ", direction: " .. newDirection)
	return self
end

function Party:changeDirection(change)
	if change == 1 then direction = direction + 1
	elseif change == -1 then direction = direction - 1
	else print 'Wat! Invalid argument to party.changeDirection' 
	end
	party.correctDirection()
	print('Party direction: ' .. direction)
end

function Party:correctDirection()
	if direction > 3 then direction = 0 end
	if direction < 0 then direction = 3 end
end

function Party:setX(new_x)
	x = new_x	
end

function Party:getX()
	return x
end

function Party:setY(new_y)
	y = new_y
end

function Party:getY()
	return y
end

function Party:getDirection()
	return direction
end

function Party:moveForward()
	if direction == 0 then
		if map[y-1][x] == 0 then
			y = y - 1
		end
	elseif direction == 1 then
		if map[y][x+1] == 0 then
			x = x + 1
		end
	elseif direction == 2 then
		if map[y+1][x] == 0 then
			y = y + 1
		end
	elseif direction == 3 then
		if map[y][x-1] == 0 then
			x = x - 1
		end
	else 
		print("Error in party orientation!")
	end
end

function Party:moveBackward()
	if direction == 0 then
		if map[y+1][x] == 0 then
			y = y + 1
		end
	elseif direction == 1 then
		if map[y][x-1] == 0 then
			x = x - 1
		end
	elseif direction == 2 then
		if map[y-1][x] == 0 then
			y = y - 1
		end
	elseif direction == 3 then
		if map[y][x+1] == 0 then
			x = x + 1
		end
	else 
		print("Error in party orientation!")
	end
end
return Party
