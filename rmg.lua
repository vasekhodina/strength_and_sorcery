--TODO: Prepsat value na id

--[[random map generaor]]--
--map values:
--empty = 0
--tunel = 1
--room = 2
--entrance = 3

rmg={}
rmg.startPosX,rmg.startPosY=0,0

generateMap = function()
	local map
	love.math.setRandomSeed(os.time())
	map = newEmptyMap(60,60) -- create empty map
	addRandomTunel(map,10,10,3,18,30) --add random tunel
	addRandomRoom(map,3,5,2,3,10) --add random room
	--map = transformMap(map)
	return map
end

newEmptyMap = function(w,h)
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

addRandomTunel = function(map,startx,starty,minlen,maxlen,count)
	local c = 0
	local timeout = 0
	local timeoutlimit = 100
	local a,b
	local sx,sy = startx,starty
	rmg.startPosX=startx
	rmg.startPosY=starty
	--TODO: Add entrance decoration value	
	
	while (c < count and timeout<timeoutlimit) do --timeout value increase number of test operations (optimal 500-1000)
		len,dir,newsx,newsy = testRandomTunel(map,sx,sy,minlen,maxlen)
		if len then
			for a=0,len do
				if dir==1 then
					map[sx+a][sy].value = 1
				elseif dir==2 then
					map[sx-a][sy].value = 1
				elseif dir==3 then
					map[sx][sy+a].value = 1
				elseif dir==4 then
					map[sx][sy-a].value = 1
				end 
			end
			c=c+1
			sx,sy = newsx,newsy
		else
			timeout=timeout+1
		end
		if timeout>=timeoutlimit then
		print("Error - internal exception: \nTimeout " .. timeout .. " > #Generated: ".. c .. " of " .. count)
		end
	end
end

addRandomRoom = function(map,minw,maxw,minh,maxh,count)
	local c=0
	local a,b,x,y,w,h
	local timeout = 0
	local timeoutlimit = 500

	while (c < count and timeout<timeoutlimit) do --timeout value increase number of test operations (optimal 500-1000)
		x,y,w,h = testRandomRoom(map,minw,maxw,minh,maxh)
		if x then
			for a=1,w do
				for b=1,h do
					map[a+x][b+y].value = 2
				end
			end
			c = c+1
		else timeout = timeout+1
		end
	end
	
	if timeout>=timeoutlimit then
		print("Error - internal exception: \nTimeout " .. timeout .. " > #Generated: ".. c .. " of " .. count)
	end
end

testRandomRoom = function(map,minw,maxw,minh,maxh)
	local a,b,x,y,w,h
	local mapW = table.getn(map)
	local mapH = table.getn(map[1])	
	local isUsed = true
	local notConnected = true
	local timeout = 0
	
	while isUsed or notConnected or timeout<100 do
		--random values
		x=love.math.random(1,mapW)
		y=love.math.random(1,mapH)
		w=love.math.random(minw,maxw)
		h=love.math.random(minh,maxh)
		isUsed = false
		isConnected = false
		
		--test bounds
		if (w+x)>mapW or (h+y)>mapH then
			isUsed = true
			timeout = timeout+1
		else
			--test intersects
			for a=1,w do
				for b=1,h do
					if map[a+x][b+y].value > 1 then
						isUsed = true
						timeout = timeout+1
					end

					if map[a+x][b+y].value == 1 then
						isConnected = true
					end
				end
			end
		end

		--return values
		if not isUsed and isConnected then
			return x,y,w,h
		else
			return false
		end
	end
end

testRandomTunel = function(map,sx,sy,minlen,maxlen)
	local a,b,len,dir
	local tooLong = true
	local timeout = 0
	local mapW = table.getn(map)
	local mapH = table.getn(map[1])
	local newsx, newsy
	
	while toLong or timeout<100 do
			len = love.math.random(minlen,maxlen)
			dir = love.math.random(1,4)
			tooLong = false
			
			if dir==1 then
				if (sx+len) > mapW then
					tooLong=true
				else
					newsx = sx+len
					newsy = sy
				end
			elseif dir==2 then
				if (sx-len) <= 0 then
					tooLong=true
				else
					newsx = sx-len
					newsy = sy
				end
			elseif dir==3 then
				if (sy+len) > mapH then
					tooLong=true
				else
					newsx = sx
					newsy = sy+len
				end
			elseif dir==4 then
				if (sy-len) <= 0 then
					tooLong=true
				else
					newsx = sx
					newsy = sy-len
				end
			end
			
			if tooLong then
				return false
			else
				return len,dir,newsx,newsy
			end
	end
end

--TEST TRASNFORM FUNCTION
transformMap = function(map)
	local a,b
	local mapW = table.getn(map)
	local mapH = table.getn(map[1])
	local transMap = {}
	
	local testString = ""
	
	for a=1,mapW do
		transMap[a]={}
		for b=1,mapH do
			if map[a][b].value == 2 then
				transMap[a][b] = 0
			elseif map[a][b].value == 1 then
				transMap[a][b] = 0
			else
				transMap[a][b] = 1
			end
			testString = testString .. transMap[a][b]
		end
		testString = testString .. "\n"
	end
	print(testString)
	return transMap
end

--TEST DRAW FUNCTION
drawMap = function(map)
	local a,b
	local mapW = table.getn(map)
	local mapH = table.getn(map[1])
	
	for a=1,mapW do
		for b=1,mapH do
			if map[a][b].value == 0 then
				love.graphics.setColor(30,30,30)
				love.graphics.rectangle("fill",(a-1)*20,(b-1)*20,20,20)
			elseif map[a][b].value == 1 then
				love.graphics.setColor(30,200,30)
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
