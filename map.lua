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
function map:getMapSquare(x,y,range,direction)
	local map_square = {}
	for i=1,4 do map_sqare[i] = {} end
	--if direction is to north, we always move the beginning to left bottom of matrix
	if direction == 0 then
		x = x - math.floor(x/range)
		for i=1,range do
			for j=1,range do
				if x+j <= 0 or x+j > #Map.currentMap or y-i <= 0 or y-i > #Map.currentMap
					then map_square[i][j] = 0
					else map_square[i][j] = Map.currentMap[y-i][x+j]
			end
		end
	end
	--TODO finish
	--if direction is to east
	if direction == 0 then
		y = y - math.floor(y/range)
		for i=1,range do
			for j=1,range do

			end
		end
	end
	--if direction is to south
	if direction == 0 then
		x = x + math.floor(x/range)
		for i=1,range do
			for j=1,range do

			end
		end
	end
	--if direction is to west
	if direction == 0 then
		x = y + math.floor(y/range)
		for i=1,range do
			for j=1,range do

			end
		end
	end


return Map
