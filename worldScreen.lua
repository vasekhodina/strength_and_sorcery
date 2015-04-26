-- worldScreen.lua a class that handles drawing in the "game Window" or world screen
local WS = {}

map = require "map"

local lWallCoords = {{0,0}, {128,40}, {240,86}, {296,104}}
local rWallCoords = {{896,0}, {896-128,40}, {896-240,86}, {896-296,104}}
local fWallCoords = {}
function WS.loadWorldScreen()
	floor = love.graphics.newImage("assets/world/floor_mud.png")
	roof = love.graphics.newImage("assets/world/roof_wood_wip.png")

	front_wall1 = love.graphics.newImage("assets/world/woodwall_front1.png")
	front_wall2 = love.graphics.newImage("assets/world/woodwall_front2.png")
	front_wall3 = love.graphics.newImage("assets/world/woodwall_front3.png")
	
	left_wall1 = love.graphics.newImage("assets/world/woodwall_pers01.png")
	left_wall2 = love.graphics.newImage("assets/world/woodwall_pers02.png")
	left_wall3 = love.graphics.newImage("assets/world/woodwall_pers03.png")
	left_wall4 = love.graphics.newImage("assets/world/woodwall_pers04.png")

	lft_wall1 = love.graphics.newImage("assets/world/woodwall_left1.png")
	lft_wall2 = love.graphics.newImage("assets/world/woodwall_left2.png")
	lft_wall3 = love.graphics.newImage("assets/world/woodwall_left3.png")

end

function WS.drawWorldScreen(party,map)
	love.graphics.draw(floor,0,264)
	love.graphics.draw(roof)
	if party.direction == 0 then WS.drawNorthView(party.x, party.y, map) end
	if party.direction == 1 then WS.drawEastView(party.x, party.y, map) end
	if party.direction == 2 then WS.drawSouthView(party.x, party.y, map) end
	if party.direction == 3 then WS.drawWestView(party.x, party.y, map) end
end

-- Draws the north view, x and y are coordinates of the start of view
function WS.drawNorthView(x,y,map)
	local currentMap = map.currentMap
	
	--3rd tile
	if (y - 3) > 0 then
		if currentMap[y-3][x-1] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2])
		end
		if currentMap[y-3][x+1] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1,1)
		end
		if currentMap[y-3][x] == 1 then love.graphics.draw(front_wall3,lWallCoords[4][1],lWallCoords[4][2])
		end
	end

    	-- 2nd tile
	if y - 2 > 0 then
		if currentMap[y-2][x-1] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1], lWallCoords[3][2])
		elseif currentMap[y-3][x-1] == 1 then love.graphics.draw(lft_wall3, 0, lWallCoords[4][2]) 
		end
		if currentMap[y-2][x+1] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1,1)
		elseif currentMap[y-3][x+1] == 1 then love.graphics.draw(lft_wall3, 896, rWallCoords[4][2],0,-1,1) 
		end
		if currentMap[y-2][x] == 1 then 
			love.graphics.draw(front_wall2,lWallCoords[3][1],lWallCoords[3][2]) 
		end
	end

    -- 1st tile
	if y - 1 > 0 then
		if currentMap[y-1][x-1] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1],lWallCoords[2][2])
		elseif currentMap[y-2][x-1] == 1 then love.graphics.draw(lft_wall2, 0 ,lWallCoords[3][2]) 
		end
		if currentMap[y-1][x+1] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1],rWallCoords[2][2],0,-1,1)
		elseif currentMap[y-2][x+1] == 1 then love.graphics.draw(lft_wall2, 896,rWallCoords[3][2],0,-1,1) 
		end
		if currentMap[y-1][x] == 1 then 
			love.graphics.draw(front_wall1,lWallCoords[2][1],lWallCoords[2][2]) 
		end
		
		-- tile with the party on. 0th tile
		if currentMap[y][x-1] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2])
		elseif currentMap[y-1][x-1] == 1 then love.graphics.draw(lft_wall1, lWallCoords[1][1],lWallCoords[2][2]) 
		end
		if currentMap[y][x+1] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1,1)
		elseif currentMap[y-1][x+1] == 1 then love.graphics.draw(lft_wall1, rWallCoords[1][1],rWallCoords[2][2],0,-1,1) 
		end
	end
end

function WS.drawSouthView(x,y,map)
	local currentMap = map.currentMap
	
--[[	--3rd tile
	if (y + 3) > 0 then
		if currentMap[y+3][x+1] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2])
		end
		if currentMap[y+3][x-1] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1)
		end
		if currentMap[y+3][x] == 1 then love.graphics.draw(front_wall3,lWallCoords[4][1],lWallCoords[4][2])  end
	end

    	-- 2nd tile
	if y + 2 > 0 then
		if currentMap[y+2][x+1] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1],lWallCoords[3][2])
		elseif currentMap[y+3][x+1] == 1 then love.graphics.draw(lft_wall3, 0, 50) 
		end
		if currentMap[y+2][x-1] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1)
		elseif currentMap[y+3][x-1] == 1 then love.graphics.draw(lft_wall3, rWallCoords[3], 50,0,-1) 
		end
		if currentMap[y+2][x] == 1 then 
			love.graphics.draw(front_wall2,lWallCoords[3][1],lWallCoords[3][2]) 
		end
	end

    -- 1st tile
	if y + 1 > 0 then
		if currentMap[y+1][x+1] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1],lWallCoords[2][2])
		elseif currentMap[y+2][x+1] == 1 then love.graphics.draw(lft_wall2, 0, 40) 
		end
		if currentMap[y+1][x-1] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1],rWallCoords[2][2],0,-1)
		elseif currentMap[y+2][x-1] == 1 then love.graphics.draw(lft_wall2, rWallCoords[2], 40,0,-1) 
		end
		if currentMap[y+1][x] == 1 then 
			love.graphics.draw(front_wall1,lWallCoords[2][1],lWallCoords[2][2]) 
		end
		
		-- tile with the party on. 0th tile
		if currentMap[y][x+1] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2])
		elseif currentMap[y+1][x+1] == 1 then love.graphics.draw(lft_wall1, 0, 18) 
		end
		if currentMap[y][x-1] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1)
		elseif currentMap[y+1][x-1] == 1 then love.graphics.draw(lft_wall1, rWallCoords[1], 18,0,-1) 
		end
	end]]--
	--3rd tile
	if (y + 3) > 0 then
		if currentMap[y+3][x+1] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2])
		end
		if currentMap[y+3][x-1] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1,1)
		end
		if currentMap[y+3][x] == 1 then love.graphics.draw(front_wall3,lWallCoords[4][1],lWallCoords[4][2])
		end
	end

    	-- 2nd tile
	if y + 2 > 0 then
		if currentMap[y+2][x+1] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1], lWallCoords[3][2])
		elseif currentMap[y+3][x+1] == 1 then love.graphics.draw(lft_wall3, 0, lWallCoords[4][2]) 
		end
		if currentMap[y+2][x-1] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1,1)
		elseif currentMap[y+3][x-1] == 1 then love.graphics.draw(lft_wall3, 896, rWallCoords[4][2],0,-1,1) 
		end
		if currentMap[y+2][x] == 1 then 
			love.graphics.draw(front_wall2,lWallCoords[3][1],lWallCoords[3][2]) 
		end
	end

    -- 1st tile
	if y + 1 > 0 then
		if currentMap[y+1][x+1] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1],lWallCoords[2][2])
		elseif currentMap[y+2][x+1] == 1 then love.graphics.draw(lft_wall2, 0 ,lWallCoords[3][2]) 
		end
		if currentMap[y+1][x-1] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1],rWallCoords[2][2],0,-1,1)
		elseif currentMap[y+2][x-1] == 1 then love.graphics.draw(lft_wall2, 896,rWallCoords[3][2],0,-1,1) 
		end
		if currentMap[y+1][x] == 1 then 
			love.graphics.draw(front_wall1,lWallCoords[2][1],lWallCoords[2][2]) 
		end
		
		-- tile with the party on. 0th tile
		if currentMap[y][x+1] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2])
		elseif currentMap[y+1][x+1] == 1 then love.graphics.draw(lft_wall1, lWallCoords[1][1],lWallCoords[2][2]) 
		end
		if currentMap[y][x-1] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1,1)
		elseif currentMap[y+1][x-1] == 1 then love.graphics.draw(lft_wall1, rWallCoords[1][1],rWallCoords[2][2],0,-1,1) 
		end
	end
end

function WS.drawWestView(x,y,map)
	local currentMap = map.currentMap
	
	--[[3rd tile
	if (x - 3) > 0 then
		if currentMap[y+1][x-3] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2])
		end
		if currentMap[y-1][x-3] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1)
		end
		if currentMap[y][x-3] == 1 then love.graphics.draw(front_wall3,lWallCoords[4][1],lWallCoords[4][2])  end
	end

    	-- 2nd tile
	if x - 2 > 0 then
		if currentMap[y+1][x-2] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1],lWallCoords[3][2])
		elseif currentMap[y+1][x-3] == 1 then love.graphics.draw(lft_wall3, 0, 50) 
		end
		if currentMap[y-1][x-2] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1)
		elseif currentMap[y-1][x-3] == 1 then love.graphics.draw(lft_wall3, rWallCoords[3], 50,0,-1) 
		end
		if currentMap[y][x-2] == 1 then 
			love.graphics.draw(front_wall2,lWallCoords[3][1],lWallCoords[3][2]) 
		end
	end

    -- 1st tile
	if x - 1 > 0 then
		if currentMap[y+1][x-1] == 1 then love.graphics.draw(left_wall2alt, lWallCoords[2][1],lWallCoords[2][2])
		elseif currentMap[y+1][x-2] == 1 then love.graphics.draw(lft_wall2, 0, 40) 
		end
		if currentMap[y-1][x-1] == 1 then love.graphics.draw(left_wall2alt, rWallCoords[2][1],rWallCoords[2][2],0,-1)
		elseif currentMap[y-1][x-2] == 1 then love.graphics.draw(lft_wall2, rWallCoords[2], 40,0,-1) 
		end
		if currentMap[y][x-1] == 1 then 
			love.graphics.draw(front_wall1,lWallCoords[2][1],lWallCoords[2][2]) 
		end
		
		-- tile with the party on. 0th tile
		if currentMap[y+1][x] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2])
		elseif currentMap[y+1][x-1] == 1 then love.graphics.draw(lft_wall1, 0, 18) 
		end
		if currentMap[y-1][x] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1)
		elseif currentMap[y-1][x-1] == 1 then love.graphics.draw(lft_wall1, rWallCoords[1], 18,0,-1) 
		end
	end]]--
	--3rd tile
	if x - 3 > 0 then
		if currentMap[y+1][x-3] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2])
		end
		if currentMap[y-1][x-3] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1,1)
		end
		if currentMap[y][x-3] == 1 then love.graphics.draw(front_wall3,lWallCoords[4][1],lWallCoords[4][2])
		end
	end

    	-- 2nd tile
	if x - 2 > 0 then
		if currentMap[y+1][x-2] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1], lWallCoords[3][2])
		elseif currentMap[y+1][x-3] == 1 then love.graphics.draw(lft_wall3, 0, lWallCoords[4][2]) 
		end
		if currentMap[y-1][x-2] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1,1)
		elseif currentMap[y-1][x-3] == 1 then love.graphics.draw(lft_wall3, 896, rWallCoords[4][2],0,-1,1) 
		end
		if currentMap[y][x-2] == 1 then 
			love.graphics.draw(front_wall2,lWallCoords[3][1],lWallCoords[3][2]) 
		end
	end

    -- 1st tile
	if x - 1 > 0 then
		if currentMap[y+1][x-1] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1],lWallCoords[2][2])
		elseif currentMap[y+1][x-2] == 1 then love.graphics.draw(lft_wall2, 0 ,lWallCoords[3][2]) 
		end
		if currentMap[y-1][x-1] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1],rWallCoords[2][2],0,-1,1)
		elseif currentMap[y-1][x-2] == 1 then love.graphics.draw(lft_wall2, 896,rWallCoords[3][2],0,-1,1) 
		end
		if currentMap[y][x-1] == 1 then 
			love.graphics.draw(front_wall1,lWallCoords[2][1],lWallCoords[2][2]) 
		end
		
		-- tile with the party on. 0th tile
		if currentMap[y+1][x] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2])
		elseif currentMap[y+1][x-1] == 1 then love.graphics.draw(lft_wall1, lWallCoords[1][1],lWallCoords[2][2]) 
		end
		if currentMap[y-1][x] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1,1)
		elseif currentMap[y-1][x-1] == 1 then love.graphics.draw(lft_wall1, rWallCoords[1][1],rWallCoords[2][2],0,-1,1) 
		end
	end
end

function WS.drawEastView(x,y,map)
	local currentMap = map.currentMap
	
	--[[3rd tile
	if (x + 3) > 0 then
		if currentMap[y-1][x+3] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2])
		end
		if currentMap[y+1][x+3] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1)
		end
		if currentMap[y][x+3] == 1 then love.graphics.draw(front_wall3,lWallCoords[4][1],lWallCoords[4][2])  end
	end

    	-- 2nd tile
	if x + 2 > 0 then
		if currentMap[y-1][x+2] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1],lWallCoords[3][2])
		elseif currentMap[y-1][x+3] == 1 then love.graphics.draw(lft_wall3, 0, 50) 
		end
		if currentMap[y+1][x+2] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1)
		elseif currentMap[y+1][x+3] == 1 then love.graphics.draw(lft_wall3, rWallCoords[3], 50,0,-1) 
		end
		if currentMap[y][x+2] == 1 then 
			love.graphics.draw(front_wall2,lWallCoords[3][1],lWallCoords[3][2]) 
		end
	end

    -- 1st tile
	if x + 1 > 0 then
		if currentMap[y-1][x+1] == 1 then love.graphics.draw(left_wall2alt, lWallCoords[2][1],lWallCoords[2][2])
		elseif currentMap[y-1][x+2] == 1 then love.graphics.draw(lft_wall2, 0, 40) 
		end
		if currentMap[y+1][x+1] == 1 then love.graphics.draw(left_wall2alt, rWallCoords[2][1],rWallCoords[2][2],0,-1)
		elseif currentMap[y+1][x+2] == 1 then love.graphics.draw(lft_wall2, rWallCoords[2], 40,0,-1) 
		end
		if currentMap[y][x+1] == 1 then 
			love.graphics.draw(front_wall1,lWallCoords[2][1],lWallCoords[2][2]) 
		end
		
		-- tile with the party on. 0th tile
		if currentMap[y-1][x] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2])
		elseif currentMap[y-1][x+1] == 1 then love.graphics.draw(lft_wall1, 0, 18) 
		end
		if currentMap[y+1][x] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1)
		elseif currentMap[y+1][x+1] == 1 then love.graphics.draw(lft_wall1, rWallCoords[1], 18,0,-1) 
		end
	end]]--
	if x + 3 > 0 then
		if currentMap[y-1][x+3] == 1 then love.graphics.draw(left_wall4, lWallCoords[4][1],lWallCoords[4][2])
		end
		if currentMap[y+1][x+3] == 1 then love.graphics.draw(left_wall4, rWallCoords[4][1],rWallCoords[4][2],0,-1,1)
		end
		if currentMap[y][x+3] == 1 then love.graphics.draw(front_wall3,lWallCoords[4][1],lWallCoords[4][2])
		end
	end

    	-- 2nd tile
	if x +  2 > 0 then
		if currentMap[y-1][x+2] == 1 then love.graphics.draw(left_wall3, lWallCoords[3][1], lWallCoords[3][2])
		elseif currentMap[y-1][x+3] == 1 then love.graphics.draw(lft_wall3, 0, lWallCoords[4][2]) 
		end
		if currentMap[y+1][x+2] == 1 then love.graphics.draw(left_wall3, rWallCoords[3][1],rWallCoords[3][2],0,-1,1)
		elseif currentMap[y+1][x+3] == 1 then love.graphics.draw(lft_wall3, 896, rWallCoords[4][2],0,-1,1) 
		end
		if currentMap[y][x+2] == 1 then 
			love.graphics.draw(front_wall2,lWallCoords[3][1],lWallCoords[3][2]) 
		end
	end

    -- 1st tile
	if x + 1 > 0 then
		if currentMap[y-1][x+1] == 1 then love.graphics.draw(left_wall2, lWallCoords[2][1],lWallCoords[2][2])
		elseif currentMap[y-1][x+2] == 1 then love.graphics.draw(lft_wall2, 0 ,lWallCoords[3][2]) 
		end
		if currentMap[y+1][x+1] == 1 then love.graphics.draw(left_wall2, rWallCoords[2][1],rWallCoords[2][2],0,-1,1)
		elseif currentMap[y+1][x+2] == 1 then love.graphics.draw(lft_wall2, 896,rWallCoords[3][2],0,-1,1) 
		end
		if currentMap[y][x+1] == 1 then 
			love.graphics.draw(front_wall1,lWallCoords[2][1],lWallCoords[2][2]) 
		end
		
		-- tile with the party on. 0th tile
		if currentMap[y-1][x] == 1 then love.graphics.draw(left_wall1, lWallCoords[1][1],lWallCoords[1][2])
		elseif currentMap[y-1][x+1] == 1 then love.graphics.draw(lft_wall1, lWallCoords[1][1],lWallCoords[2][2]) 
		end
		if currentMap[y+1][x] == 1 then love.graphics.draw(left_wall1, rWallCoords[1][1],rWallCoords[1][2],0,-1,1)
		elseif currentMap[y+1][x+1] == 1 then love.graphics.draw(lft_wall1, rWallCoords[1][1],rWallCoords[2][2],0,-1,1) 
		end
	end
end

return WS
