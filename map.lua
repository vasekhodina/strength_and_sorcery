-- map.lua the class with functions and variables uded with maps
local Map = {}

Map.currentMap = {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
									{1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
									{1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
									{1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1},
									{1,0,1,0,1,1,0,0,0,0,0,0,1,1,0,0,0,1,1,1},
									{1,0,1,0,1,1,1,1,1,1,1,0,0,0,0,1,0,1,1,1},
									{1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1},
									{1,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1},
									{1,0,1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,1,1}, 
									{1,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1},
									{1,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1}, 
									{1,0,1,0,0,0,0,1,0,0,0,0,1,1,1,1,0,1,1,1},
									{1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
									{1,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,0,1},
									{1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
									{1,0,1,1,1,0,1,0,1,0,1,1,1,1,1,1,0,1,1,1},
									{1,0,1,1,1,0,1,0,1,0,1,1,1,1,1,1,0,1,1,1},
								  {1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,1},
								  {1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1},
								  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}

Map.items = {}

--Function that provides a matrix that is a part of map, 
--It takes x,y position on the map, range how big the matrix should be and a direction where it should be progressing
--It takes x,y as center of one side of square and maps all the tiles in from of it in the specified direction
function Map:getMapSquare(x,y,direction,range)
	local map_square = {}
	for i=1,range do map_square[i] = {} end
	--if direction is to north, we always move the beginning to left bottom of matrix
	if direction == 0 then
		x = x - math.floor(range/2)-1
		y = y+1
		for i=1,range do
			for j=1,range do
				if x+j <= 0 or x+j > #Map.currentMap or y-i <= 0 or y-i > #Map.currentMap
					then map_square[i][j] = 0
					else map_square[i][j] = Map.currentMap[y-i][x+j]
				end
			end
		end
	end
	--if direction is to east
	if direction == 1 then
		y = y - math.floor(range/2)-1
		x = x-1
		for i=1,range do
			for j=1,range do
				if x+i <= 0 or x+i > #Map.currentMap or y+j <= 0 or y+j > #Map.currentMap 
					then map_square[i][j] = 0
					else map_square[i][j] = Map.currentMap[y+j][x+i]
				end
			end
		end
	end
	--if direction is to south
	if direction == 2 then
		x = x + math.floor(range/2)+1
		y = y-1
		for i=1,range do
			for j=1,range do
				if y+i <= 0 or y+i > #Map.currentMap or x-j <= 0 or x-j > #Map.currentMap 
					then map_square[i][j] = 0
					else map_square[i][j] = Map.currentMap[y+i][x-j]
				end
			end
		end
	end
	--if direction is to west
	if direction == 3 then
		y = y + math.floor(range/2)+1
		x = x+1
		for i=1,range do
			for j=1,range do
				if x-i <= 0 or x-i > #Map.currentMap or y-j <= 0 or y-j > #Map.currentMap 
					then map_square[i][j] = 0
					else map_square[i][j] = Map.currentMap[y-j][x-i]
				end
			end
		end
	end
	return map_square
end

return Map
