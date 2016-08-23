-- worldScreen.lua a class that handles drawing in the "game Window" or world screen
local WS = {}

map = require "map"
Party = require "party"

local lWallCoords = {{1,1}, {1,10}, {1,20}, {9,26}}
local rWallCoords = {{225,1}, {225,10}, {225,20}, {217,26}}
local fWallCoords = {{32,10}, {59,20}, {78,26}, {90,31}}
local far_l_wall_coords = {{1,25}, {1,26}}
local far_r_wall_coords = {{225,25}, {225,26}}
local far_row_wall_coords = {{0,31}, {45,31}, {90,31}, {135,31}, {180,31}}
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
	floor = love.graphics.newImage("assets/world/concrete/floor.png")
	roof = love.graphics.newImage("assets/world//orig_templates/ceiling_template.png")

	front_wall1 = love.graphics.newImage("assets/world/orig_templates/front1_template.png")
	front_wall2 = love.graphics.newImage("assets/world/orig_templates/front2_template.png")
	front_wall3 = love.graphics.newImage("assets/world/orig_templates/front3_template.png")
	front_wall4 = love.graphics.newImage("assets/world/orig_templates/front4_template.png")
	
	left_wall1 = love.graphics.newImage("assets/world/orig_templates/side0_template.png")
	left_wall2 = love.graphics.newImage("assets/world/orig_templates/side1_template.png")
	left_wall3 = love.graphics.newImage("assets/world/orig_templates/side2_template.png")
	left_wall4 = love.graphics.newImage("assets/world/orig_templates/side3_template.png")

	far_left_wall2 = love.graphics.newImage("assets/world/orig_templates/farside2_template.png")
	far_left_wall3 = love.graphics.newImage("assets/world/orig_templates/farside3_template.png")
	exit = {}
	exit[1] = love.graphics.newImage("assets/world/exit1.png")
	exit[2] = love.graphics.newImage("assets/world/exit2.png")
	exit[3] = love.graphics.newImage("assets/world/exit3.png")
end

function WS:drawWorldScreen()
	love.graphics.draw(floor,floor_coords[1],floor_coords[2],0,1)
	love.graphics.draw(roof,ceiling_coords[1],ceiling_coords[2],0,1)
	viewMatrix = map:getMapSquare(self.party:getX(), self.party:getY(), self.party:getDirection(), 5)
	--draw last row of walls
	for i=1,5 do
		if viewMatrix[5][i] == 1 then love.graphics.draw(front_wall4, far_row_wall_coords[i][1],far_row_wall_coords[i][2],0,1) end			
	end

	--Weird order of drawing is caused by sidewalls getting hidden by frontwalls etc.
	if viewMatrix[4][1] == 1 then love.graphics.draw(far_left_wall3,far_l_wall_coords[2][1],far_l_wall_coords[2][2],0,1) end			
	if viewMatrix[4][5] == 1 then love.graphics.draw(far_left_wall3,far_r_wall_coords[2][1],far_r_wall_coords[2][2],0,-1, 1) end			
	if viewMatrix[4][2] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2],0,1) end			
	if viewMatrix[4][4] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1,1) end			
	if viewMatrix[4][3] == 1 then love.graphics.draw(front_wall3,fWallCoords[3][1],fWallCoords[3][2],0,1) end			

	if viewMatrix[3][1] == 1 then love.graphics.draw(far_left_wall2,far_l_wall_coords[1][1],far_l_wall_coords[1][2],0,1) end			
	if viewMatrix[3][5] == 1 then love.graphics.draw(far_left_wall2,far_r_wall_coords[1][1],far_r_wall_coords[1][2],0,-1, 1) end			
	if viewMatrix[3][2] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1],lWallCoords[3][2],0,1) end			
	if viewMatrix[3][4] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1,1) end			
	if viewMatrix[3][3] == 1 then love.graphics.draw(front_wall2,fWallCoords[2][1],fWallCoords[2][2],0,1) end			

	if viewMatrix[2][2] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1],lWallCoords[2][2],0,1) end			
	if viewMatrix[2][4] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1],rWallCoords[2][2],0,-1,1) end			
	if viewMatrix[2][3] == 1 then love.graphics.draw(front_wall1,fWallCoords[1][1],fWallCoords[1][2],0,1) end			

	if viewMatrix[1][2] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2],0,1) end			
	if viewMatrix[1][4] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1,1) end			

	if self.party:getX() == 4 and self.party.getY() == 19 and self.party.getDirection() == 3 then
		love.graphics.draw(exit[3], fWallCoords[3][1], fWallCoords[3][2])
	end
	if self.party:getX() == 3 and self.party.getY() == 19 and self.party.getDirection() == 3 then
		love.graphics.draw(exit[2], fWallCoords[2][1], fWallCoords[2][2])
	end
	if self.party:getX() == 2 and self.party.getY() == 19 and self.party.getDirection() == 3 then
		love.graphics.draw(exit[1], fWallCoords[1][1], fWallCoords[1][2])
	end
end                                                                            

--- This function checks if pixel at x,y coordinates belongs to a sprite and is opaque.
-- @param sprite The sprite to check
-- @param x The x coordinate of the pixel
-- @param y The x coordinate of the pixel
-- @return T/F if the pixel is opaque or not
function WS:isXYOpaque(sprite, x, y)
	pixel = sprite:getData():getPixel(x,y)
	if pixel[a] ~= 0 then
		return true
	else 
		return false
	end
end

--- Function callback deciding if the sprite (item, wall decor) has been clicked and should be activated
-- @param sprite The sprite that should be activated
-- @param sx X coord of the sprite
-- @param sy Y coord of the sprite
-- @param x X coord of the place of contact (mouseclick)
-- @param y Y coord of the place of contact (mouseclick)
-- @return T/F if the sprite should be activated
function WS:activateSprite(sprite, sx, sy, x, y)
	if x >= sx and x < sx + sprite.getWidth()
	and y >= sy and y < sy + sprite.getHeigth() 
	and WS:isXYOpaque(sprite, x, y) then
		return true
	else
		return false
	end
end
return WS
