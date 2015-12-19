-- party.lua
-- class containing necessary things about party

local party = {}

-- keeps party direction 0 - north, 1 - east, 2 - south, 3 - west 
map = require "map"
party.direction = 0
party.x = 17
party.y = 6

function party.changeDirection(change)
	if change == 1 then party.direction = party.direction + 1
	elseif change == -1 then party.direction = party.direction - 1
	else print 'Wat! Invalid argument to party.changeDirection' 
	end
	party.correctDirection()
	print('Party direction: ' .. party.direction)
end

function party.correctDirection()
	if party.direction > 3 then party.direction = 0 end
	if party.direction < 0 then party.direction = 3 end
end

function party.moveForward()
	if party.direction == 0 then
		if map.currentMap[party.y-1][party.x] == 0 then
			party.y = party.y - 1
		end
	elseif party.direction == 1 then
		if map.currentMap[party.y][party.x+1] == 0 then
			party.x = party.x + 1
		end
	elseif party.direction == 2 then
		if map.currentMap[party.y+1][party.x] == 0 then
			party.y = party.y + 1
		end
	elseif party.direction == 3 then
		if map.currentMap[party.y][party.x-1] == 0 then
			party.x = party.x - 1
		end
	else 
		print("Error in party orientation!")
	end
	print('Party position:' .. ' ' .. party.x .. ' ' .. party.y)
end

function party.moveBackward(map)

end
return party
