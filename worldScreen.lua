-- worldScreen.lua a class that handles drawing in the "game Window" or world screen
local WS = {}

map = require "map"
Party = require "Party"

local lWallCoords = {{4,4}, {4,24}, {4,74}, {4,124}}
local rWallCoords = {{900,4}, {900,24}, {900,74}, {900,124}}
local fWallCoords = {{4,4}, {128,24}, {240,74}, {296,124}}
local SCALE = 4

function WS:newWorldScreen(newParty)
	party = newParty
	WS:loadWorldScreen()
end


function WS:loadWorldScreen()
	floor = love.graphics.newImage("assets/world/dm2/floor.png")
	roof = love.graphics.newImage("assets/world//dm2/ceiling.png")

	front_wall1 = love.graphics.newImage("assets/world/dm2/front1.png")
	front_wall2 = love.graphics.newImage("assets/world/dm2/front2.png")
	front_wall3 = love.graphics.newImage("assets/world/dm2/front3.png")
	
	left_wall1 = love.graphics.newImage("assets/world/dm2/side1.png")
	left_wall2 = love.graphics.newImage("assets/world/dm2/side2.png")
	left_wall3 = love.graphics.newImage("assets/world/dm2/side3.png")
	left_wall4 = love.graphics.newImage("assets/world/dm2/side4.png")

	lft_wall1 = love.graphics.newImage("assets/world/dm2/side1alt.png")
	lft_wall2 = love.graphics.newImage("assets/world/dm2/side2alt.png")
	lft_wall3 = love.graphics.newImage("assets/world/dm2/side3alt.png")

end

function WS:drawWorldScreen(party,map)
	love.graphics.draw(floor,4,212,0,SCALE)
	love.graphics.draw(roof,4,4,0,SCALE)
	viewMatrix = WS:createViewMatrix(party:getX(), party:getY(), party:getDirection(), map.currentMap)
	if viewMatrix[4][1] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2],0,SCALE) end			
	if viewMatrix[4][3] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-SCALE,SCALE) end			
	if viewMatrix[4][2] == 1 then love.graphics.draw(front_wall3,fWallCoords[4][1],fWallCoords[4][2],0,SCALE) end			

	if viewMatrix[3][1] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1],lWallCoords[3][2],0,SCALE) end			
	if viewMatrix[3][3] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-SCALE,SCALE) end			
	if viewMatrix[3][2] == 1 then love.graphics.draw(front_wall2,fWallCoords[3][1],fWallCoords[3][2],0,SCALE) end			

	if viewMatrix[2][1] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1],lWallCoords[2][2],0,SCALE) end			
	if viewMatrix[2][3] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1],rWallCoords[2][2],0,-SCALE,SCALE) end			
	if viewMatrix[2][2] == 1 then love.graphics.draw(front_wall1,fWallCoords[2][1],fWallCoords[2][2],0,SCALE) end			

	if viewMatrix[1][1] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2],0,SCALE) end			
	if viewMatrix[1][3] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-SCALE,SCALE) end			
end

function WS:createViewMatrix(x,y,partyDirection,currentMap)
	local viewMatrix = {}
	for i=1,4 do viewMatrix[i] = {} end
	if partyDirection == 0 then
		for i=1,4 do
			for j=1,3 do 
				if y-i-1 <=0 or y-i-1 > #currentMap or x+j-2 <= 0 or x+j-2 > #currentMap[i] 
				then viewMatrix[i][j] = 1
				else viewMatrix[i][j] = currentMap[y-i][x+j-2] 
				end
			end
		end
	end
	if partyDirection == 1 then
		for i=1,4 do
			for j=1,3 do viewMatrix[i][j] = currentMap[x+j][y+i-2] end
		end
	end
	if partyDirection == 2 then
		for i=1,4 do
			for j=1,3 do viewMatrix[i][j] = currentMap[y+i][x-j+2] end
		end
	end
	if partyDirection == 3 then
		for i=1,4 do
			for j=1,3 do viewMatrix[i][j] = currentMap[x-j+1][y+i+2] end
		end
	end
	for i=1,4 do print(viewMatrix[i][1] .. viewMatrix[i][2] .. viewMatrix[i][3]) end	
	print("\n")
	return viewMatrix
end

return WS
