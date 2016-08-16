--[[random map generaor]]--
--map values:
--empty = 0
--tunel = 1
--room = 2

function newEmptyMap(w,h)
	local a,b
	local map = {}
	for a=1,w do
		map[a]={}
		for b=1,h do
			map[a][b]={}
			map[a][b].value = 0
		end
	end
	return map
end

function addRandomRoom(map,maxw,maxh,count)
	local c=0
	local a,b,x,y,w,h

	while (c < count) do
		x,y,w,h = testRandomRoom(map,maxw,maxh)
		if x then
			for a=1,w do
				for b=1,h do
					map[a+x][b+y].value = 2
				end
			end
			c = c+1
			print(c)
		end
	end
end

function testRandomRoom(map,maxw,maxh)
	local a,b,x,y,w,h
	local mapW = table.getn(map)
	local mapH = table.getn(map[1])	
	local isUsed = true
	local timeout = 0
	
	while isUsed or timeout<100 do
		--random values
		x=love.math.random(1,mapW)
		y=love.math.random(1,mapH)
		w=love.math.random(2,maxw)
		h=love.math.random(2,maxh)
		isUsed = false
		
		--test bounds
		if (w+x)>mapW or (h+y)>mapH then
			isUsed = true
			timeout = timeout+1
		else
			--test intersects
			for a=1,w do
				for b=1,h do
					if map[a+x][b+y].value > 0 then
						isUsed = true
						timeout = timeout+1
					end
				end
			end
		end
		
		--with no "out of bounds" of intersects, return values
		if not isUsed then
			return x,y,w,h
		else
			return false
		end
	end
end

--TODO: after optimalization, move this function out of generator
function drawMap(map)
	local a,b
	local mapW = table.getn(map)
	local mapH = table.getn(map[1])
	
	for a=1,mapW do
		for b=1,mapH do
			if map[a][b].value == 0 then
				love.graphics.setColor(30,30,30)
				love.graphics.rectangle("fill",(a-1)*20,(b-1)*20,20,20)
			elseif map[a][b].value == 1 then
				love.graphics.setColor(200,200,200)
				love.graphics.rectangle("fill",(a-1)*20,(b-1)*20,20,20)
			elseif map[a][b].value == 2 then
				love.graphics.setColor(30,200,30)
				love.graphics.rectangle("fill",(a-1)*20,(b-1)*20,20,20)
			end
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("line",(a-1)*20,(b-1)*20,20,20)
		end
	end
end
