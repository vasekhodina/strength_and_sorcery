-- worldScreen.lua a class that handles drawing in the "game Window" or world screen
local WS = {}

map = require "map"
Party = require "Party"

local lWallCoords = {{1,1}, {1,10}, {1,20}, {7,29}}
local rWallCoords = {{225,1}, {225,10}, {225,20}, {219,29}}
local fWallCoords = {{1,1}, {30,7}, {59,18}, {77,27}}
local floor_coords = {1,40}
local ceiling_coords = {1,1}
local party = 0
local local_map = 0
viewMatrix = 0

function WS:newWorldScreen(newParty,newMap)
	self.party = newParty
	self.local_map = newMap
	print("Info: Created World screen with party: " .. party)
	WS:loadWorldScreen()
	return self
end


function WS:loadWorldScreen()
	floor = love.graphics.newImage("assets/world/orig_templates/floor_template.png")
	roof = love.graphics.newImage("assets/world//orig_templates/ceiling_template.png")

	front_wall1 = love.graphics.newImage("assets/world/orig_templates/front1_template.png")
	front_wall2 = love.graphics.newImage("assets/world/orig_templates/front2_template.png")
	front_wall3 = love.graphics.newImage("assets/world/orig_templates/front3_template.png")
	
	left_wall1 = love.graphics.newImage("assets/world/orig_templates/side0_template.png")
	left_wall2 = love.graphics.newImage("assets/world/orig_templates/side1_template.png")
	left_wall3 = love.graphics.newImage("assets/world/orig_templates/side2_template.png")
	left_wall4 = love.graphics.newImage("assets/world/orig_templates/side3_template.png")
end

function WS:drawWorldScreen(SCALE)
	love.graphics.draw(floor,floor_coords[1]*SCALE,floor_coords[2]*SCALE,0,SCALE)
	love.graphics.draw(roof,ceiling_coords[1]*SCALE,ceiling_coords[2]*SCALE,0,SCALE)
	viewMatrix = WS:createViewMatrix(self.party:getX(), self.party:getY(), self.party:getDirection(), self.local_map)
	if viewMatrix[4][1] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1]*SCALE,lWallCoords[4][2]*SCALE,0,SCALE) end			
	if viewMatrix[4][3] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1]*SCALE,rWallCoords[4][2]*SCALE,0,-SCALE,SCALE) end			
	if viewMatrix[4][2] == 1 then love.graphics.draw(front_wall3,fWallCoords[4][1]*SCALE,fWallCoords[4][2]*SCALE,0,SCALE) end			

	if viewMatrix[3][1] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1]*SCALE,lWallCoords[3][2]*SCALE,0,SCALE) end			
	if viewMatrix[3][3] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1]*SCALE,rWallCoords[3][2]*SCALE,0,-SCALE,SCALE) end			
	if viewMatrix[3][2] == 1 then love.graphics.draw(front_wall2,fWallCoords[3][1]*SCALE,fWallCoords[3][2]*SCALE,0,SCALE) end			

	if viewMatrix[2][1] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1]*SCALE,lWallCoords[2][2]*SCALE,0,SCALE) end			
	if viewMatrix[2][3] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1]*SCALE,rWallCoords[2][2]*SCALE,0,-SCALE,SCALE) end			
	if viewMatrix[2][2] == 1 then love.graphics.draw(front_wall1,fWallCoords[2][1]*SCALE,fWallCoords[2][2]*SCALE,0,SCALE) end			

	if viewMatrix[1][1] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1]*SCALE,lWallCoords[1][2]*SCALE,0,SCALE) end			
	if viewMatrix[1][3] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1]*SCALE,rWallCoords[1][2]*SCALE,0,-SCALE,SCALE) end			
end                                                                            

function WS:createViewMatrix(x,y,partyDirection,currentMap)
	local viewMatrix = {}
	for i=1,4 do viewMatrix[i] = {} end
	if partyDirection == 0 then
		for i=1,4 do
			for j=1,3 do 
				if y-i-1 <=0 or y-i-1 > #currentMap or x+j-2 <= 0 or x+j-2 > #currentMap[i] 
				then viewMatrix[i][j] = 1
				else viewMatrix[i][j] = currentMap[y-i+1][x+j-2] 
				end
			end
		end
	end
	if partyDirection == 1 then
		for i=1,4 do
			for j=1,3 do 
				if x+i-1 <=0 or x+i-1 > #currentMap or y+j-2 <= 0 or y+j-2 > #currentMap[i]
					then viewMatrix[i][j] = 1
					else viewMatrix[i][j] = currentMap[y+j-2][x+i-1] 
				end
			end
		end
	end
	if partyDirection == 2 then
		for i=1,4 do
			for j=1,3 do 
				if y+i+1 <=0 or y+i+1 > #currentMap or x-j+2 <= 0 or x-j+2 > #currentMap[i] 
					then viewMatrix[i][j] = 1
					else viewMatrix[i][j] = currentMap[y+i-1][x-j+2] 
				end
			end
		end
	end
	if partyDirection == 3 then
		for i=1,4 do
			for j=1,3 do 
				viewMatrix[i][j] = currentMap[y-j+2][x-i+1] 
			end
		end
	end
	return viewMatrix
end

return WS
