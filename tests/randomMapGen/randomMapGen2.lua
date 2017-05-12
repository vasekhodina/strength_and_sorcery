--WORK IN PROGRESS

--MAP DATA STRUCTURE
--map.entrance={x,y,direction}	entrance point and after-use direction
--map.exit={x,y,direction}	exit point and after-use direction
--map.roomList={{x,y,width,height},{x,y,width,height},...} automatically indexed table of rooms
--matrix map[x][y]
--	.tileID=<tile id>
--	any field in matrix can have additional information with use map[x][y].table
--

wid,hei,empty,side,tunel,room,entrance,exit=arg[1] or 20,arg[2] or 20,arg[3] or "0",arg[4] or "#",arg[5] or 1,arg[6] or 2,arg[7] or "E",arg[8] or "X"
math.randomseed(os.time())

--## DEBUG VARIABLE - ON TRUE PRINT ADDITIONAL INFORMATIONS
	local DEBUG=false

--CREATE EMPTY MAP
function newMap(width,height)
	local width=width
	local height=height

	local w,h
	local map={}
	map.roomList={}
	for h=1,height do
		map[h]={}
		for w=1,width do
			map[h][w]={}
			map[h][w].tileID=empty
		end
	end
	return map
end

--MAP PRINT FUNCTION
--PRINTS MAP TO TERMINAL WINDOW WITH TABLE VALUES
function printMap(map)
	local map=map
	for i=1,#map do
			string=""
			for j=1,#map[i] do
					string=string .. " " .. map[i][j].tileID
			end
			print(string)
	end
end

-->>>>>>> CREATE MAP BORDERS <<<<<<<
--CREATE 1 SQUARE OF BORDERS AROUND MAP
function addSides(map)
	local map=map
	
	local x=#map[1]
	local y=#map
	for i=1,x do
		map[1][i].tileID=side
		map[y][i].tileID=side
	end

	for i=1,y do
		map[i][1].tileID=side
                map[i][x].tileID=side
	end
end

-->>>>>>> ADD TUNEL <<<<<<<
--GENERATE TUNEL BASED ON INPUT VALUES
--RETURN LAST POSITION OF CREATION AS NEW START POINT FOR NEXT GENERATION
function addTunel(map,startX,startY,length,direction)
	local map=map
	local startX=startX
	local startY=startY
	local length=length
	local direction=direction
	
	local xAdd,yAdd=0,0
	local newX,newY=0,0
	
	for i=0,length-1 do
		if direction=="N" then xAdd,yAdd=0,-i
		elseif direction=="S" then xAdd,yAdd=0,i
		elseif direction=="E" then xAdd,yAdd=i,0
		elseif direction=="W" then xAdd,yAdd=-i,0
		end
		map[startY+yAdd][startX+xAdd].tileID=tunel
	end
	
	newX=startX+xAdd
	newY=startY+yAdd
	
	return newX,newY
end


-->>>>>>>>> GENERATE TUNELS <<<<<<<<<<<
--GENERATE TUNELS BASED ON INPUT VALUES
--MAKES 1000 TRIES BEFORE GIVE UP AND KEEP ACTUAL VALUES
--PROCESS IN FOLLOWING STEPS:
--STEP1: INITIALIZE VARIABLES (FIRST RANDOM START POINT)
--STEP2: START LOOP
--STEP3: CHOOSE RANDOM DIRECTION OTHER THAN PREVIOUS
--STEP4: SET TUNEL LENGTH LIMIT AT SELECTED DIRECTION
--SPET5: IF LONGER THAN MINIMUM, CHOOSE RANDOM TUNEL LENGTH AND ADD TUNEL TO MAP
--STEP6: CONTINUE UNTIL REACH LIMIT (REPEAT FROM STEP 2)
--
function generateTunels(map,minLength,maxLength,maxCount)
	local map=map
	local minLength=math.floor(minLength)
	local maxLength=math.floor(maxLength)
	local maxCount=maxCount
	
	-->STEP1
	local startY=math.random(2,#map-1)
	local startX=math.random(2,#map[1]-1)
	
	local count=0
	local safetyCount=0
	
	local directions={"N","S","E","W"}
	local lastDirection=""
	local direction=""

	local newX=0
	local newY=0
	
	local limitLength=0

	-->STEP2
	while true do
		safetyCount=safetyCount+1
		if safetyCount>1000 then break end

		-->STEP3
		direction=directions[math.random(1,4)]
		while direction==lastDirection do direction=directions[math.random(1,4)] end

		-->STEP4
		if direction=="N" then
			if (startY-maxLength)<=2 then limitLength=startY-1
			else limitLength=maxLength
			end
		elseif direction=="S" then
			if (startY+maxLength)>=#map-2 then limitLength=(#map-startY-1)
			else limitLength=maxLength
			end
		elseif direction=="E" then
			if (startX+maxLength)>=#map[1]-2 then limitLength=(#map[1]-startX-1)
			else limitLength=maxLength
			end
		elseif direction=="W" then
			if (startX-maxLength)<=2 then limitLength=(startX-1)
			else limitLength=maxLength
			end
		end

		-->STEP5
		if limitLength>=minLength then
			len=math.random(minLength,limitLength)
			startX,startY=addTunel(map,startX,startY,len,direction)
			count=count+1
		end
		
		limitLength=0
		lastDirection=direction
		
		-->STEP6
		if count>=maxCount then break end
	end
end


-->>>>>>> CHECK TUNEL DISTRIBUTION <<<<<<<
--CHECK IF GENERATED TUNELS USE SPECIFIED AMOUNT OF SPACE IN EVERY QUARTER OF MAP
--WORKS IN FOLLOWING STEPS:
--STEP1: INITIALIZE VARIABLES
--STEP2: COUNT ALL TUNEL FIELDS IN EVERY QUARTER
--STEP3: CHECK IF AMOUNT IN EVERY QUARTER IS AT MINIMAL PERCENTAGE GIVEN BY corr ATRIBUTE
--RETURNS TRUE IF DISTRIBUTED EVENLY OR FALSE
--
function distributedTunels(map,corr) --corr=0.0-1 as 0-100%
	local map=map
	local corr=corr

	-->STEP1
	local recreate=false
	local correction=corr
	
	local fill1=0
	local fill2=0
	local fill3=0
	local fill4=0
	
	--STEP2
	for i=1,#map do
		for j=1,#map[1] do
			if map[i][j].tileID==tunel then
				if i<=#map/2 then
					if j<(#map[1]/2)+1 then fill1=fill1+1
					else fill2=fill2+1
					end
				else
					if j<(#map[1]/2)+1 then fill3=fill3+1
					else fill4=fill4+1
					end
				end
			end
		end
	end
	
	local totalCount=fill1+fill2+fill3+fill4
	
	--DEBUG MESSAGE TO WITH PERCENTAGE VALUES OF EVERY TEST
	if DEBUG then
		print("Fill 1 count: " .. fill1 .. " (" .. math.floor(fill1*100/totalCount)/100 .. "%)")
		print("Fill 2 count: " .. fill2 .. " (" .. math.floor(fill2*100/totalCount)/100 .. "%)")
		print("Fill 3 count: " .. fill3 .. " (" .. math.floor(fill3*100/totalCount)/100 .. "%)")
		print("Fill 4 count: " .. fill4 .. " (" .. math.floor(fill4*100/totalCount)/100 .. "%)")
		print("TotalCount: " .. totalCount)
	end
	
	--STEP3
	--distribution check (min. corr*100% of total per quarter)
	if fill1<(totalCount*corr) then return false
	elseif fill2<(totalCount*corr) then return false
	elseif fill3<(totalCount*corr) then return false
	elseif fill4<(totalCount*corr) then return false
	else return true
	end
end


-->>>>>>> CREATE ROOM <<<<<<<
--GENERATE ROOM BASED ON INPUT VALUES
--SIMPLE AxB SQUARE ROOM
--INSERT ROOM PARAMS INTO MAPS ROOM TABLE FOR LATER PURPOSES
--
function addRoom(map,width,height,xStart,yStart)
	local map=map
	local width=width
	local height=height
	local xStart=xStart
	local yStart=yStart
	
	for i=xStart,xStart+height-1 do
		for j=yStart,yStart+width-1 do
			map[i][j].tileID=room
		end
	end
	
	table.insert(map.roomList,{xStart,yStart,width,height})
end


-->>>>>>> GENERATE ROOMS <<<<<<<
--GENERATES RANDOM ROOMS BASE ON INPUT VALUES
--WORKS IN FOLLOWING STEPS:
--STEP1: INITIALIZE VARIABLES
--STEP2: START WHILE LOOP
--STEP3: SET RANDOM VARIABLES
--STEP4: CHECK IF ROOM IS CONNECTED TO TUNEL
--STEP5: CHECK IF ROOM IS NOT COVERING OTHER ROOM AND IS NOT ADJACENT
--STEP6: IF VALID ROOM THEN ADD ROOM TO MAP
--STEP7: CONTINUE UNTIL REACH LIMIT (REPEAT FROM STEP 2)
--
function generateRooms(map,minSide,maxSide,maxCount)
	local map=map
	local minSide=math.floor(minSide)
	local maxSide=math.floor(maxSide)
	local maxCount=maxCount
	
	-->STEP1
	local height=0
	local width=0
	
	local xStart=1
	local yStart=1
	
	local isConnected=false
	local isCovered=false
	
	local count=0
	local safetyCount=0
	
	-->STEP2
	while true do
		safetyCount=safetyCount+1
		if safetyCount>1000 then break end
		
		isConnected=false
		isCovered=false
		
		-->STEP3
		height=math.random(minSide,maxSide)
		width=math.random(minSide,maxSide)
		
		xStart=math.random(2,#map-height-1)
		yStart=math.random(2,#map[1]-width-1)
		
		-->STEP4
		for i=xStart,xStart+height do
			for j=yStart,yStart+width do
				if map[i][j].tileID==tunel then isConnected=true end
			end
		end
		
		-->STEP5
		for i=xStart-1,xStart+height+1 do
			for j=yStart-1,yStart+width+1 do
				if map[i][j].tileID==room then isCovered=true end
			end
		end
				
		if isConnected==true and isCovered==false then
			--DEBUG MESSAGE
			if DEBUG then
				print("height: " .. height)
				print("width: " .. width)
				print("X: " .. xStart)
				print("Y: " .. yStart)
			end
			
			addRoom(map,width,height,xStart,yStart)
			count=count+1
		end
		
		if count>=maxCount then break end
	end
end


-->>>>>>> ADD SPECIAL EFECTS <<<<<<<
--SPECIAL CHARACTERS TO MAP - MOSTLY DEBUG VALUES
--ADD CUSTOM SPECIFIC FUNCTIONS TO MAP DEFINED IN THIS FUNCTION
--MOSTLY USE FOR SPECIAL VALUES INPUT, OR GRAPHISAL ENHANCEMENTS
function addSpecials(map)
		local map=map
		--map corners
		map[#map][1].tileID="X"
		map[1][1].tileID="0"
		map[1][#map[1]].tileID="Y"
		
		--quartes draw
		for i=1,#map do map[i][math.floor(#map[1]/2)].tileID="+" end
		for j=1,#map[1] do map[math.floor(#map/2)][j].tileID="+" end
end


-->>>>>>> EXPAND ROOMS <<<<<<<
--SYNTAX: roomlist.id={xstart,ystart,width,height}
--EXPANDS ROOM THAT IS RIGHT NEXT TO THE TUNEL THAT LEADS THE SAME DIRECTION
--MAKES EXPANSION IN ALL DIRECTIONS
--REWRITES MAPS ROOM TABLE TO NEW VALUES IN EACH STEP
--WORKING IN FOLLOWING STEPS:
--STEP1: CREATE FUNCTION TO READ VALUES FROM MAPS ROOM TABLE
--STEP2: ITERATES EVERY ROOM IN MAPS ROOM TABLE
--FOR EVERY DIRECTION:
--STEP3: INSIDE ITERATION, CHECK EVERY ROOM IF HAVE ADJACENT TUNEL TO EXPAND TO
--STEP4: IF VALIED, EXPANDS IN DIRECTION AND REWRITE TUNEL TO ROOM
--STEP5: REWRITE RELEVANT DATA IN MAP ROOM TABLE
-->
--MORE ITERATIONS OF EXPANSION REMOVE MORE PROBLEMS (SEE MAIN MAP GENERATION FUNCTION)

function expandRooms(map)
	local map=map
	local width=0
	local height=0
	local xStart=1
	local yStart=1
	
	-->STEP1
	local readValues=function(roomList)
		elemCount=0
		width=roomList[3]
		height=roomList[4]
		xStart=roomList[1]
		yStart=roomList[2]
	end
	
	-->STEP2
	for key,value in ipairs(map.roomList) do
		
		--LEFT SIDE
		readValues(value)
		
		-->STEP3
		for i=xStart,xStart+height-1 do
			if map[i][yStart-1].tileID==tunel then elemCount=elemCount+1 end
		end
		
		-->STEP4
		if elemCount==height then
			for i=xStart,xStart+height-1 do
				map[i][yStart-1].tileID=room
			end
			
			--STEP5
			map.roomList[key][3]=map.roomList[key][3]+1
			map.roomList[key][2]=map.roomList[key][2]-1
		end
		
		--RIGHT SIDE
		readValues(value)
		for i=xStart,xStart+height-1 do
			if map[i][yStart+width].tileID==tunel then elemCount=elemCount+1 end
		end

		if elemCount==height then
			for i=xStart,xStart+height-1 do
				map[i][yStart+width].tileID=room
			end

			map.roomList[key][3]=map.roomList[key][3]+1
		end
		
		--TOP SIDE
		readValues(value)
		for i=yStart,yStart+width-1 do
			if map[xStart-1][i].tileID==tunel then elemCount=elemCount+1 end
		end

		if elemCount==width then
			for i=yStart,yStart+width-1 do
				map[xStart-1][i].tileID=room
			end

			map.roomList[key][4]=map.roomList[key][4]+1
			map.roomList[key][1]=map.roomList[key][1]-1
		end
		
		--BOTTOM SIDE
		readValues(value)
		for i=yStart,yStart+width-1 do
			if map[xStart+height][i].tileID==tunel then elemCount=elemCount+1 end
		end

		if elemCount==width then
			for i=yStart,yStart+width-1 do
				map[xStart+height][i].tileID=room
			end

			map.roomList[key][4]=map.roomList[key][4]+1
		end
	end
end


-->>>>>>> CORRECT TUNELS <<<<<<<
--CORRECT THREE OR MORE ADJACENT TUNELS BY REMOVING INNER TUNEL SQUARES
--CHECK EVERY SQYARE IF THERE IS ANY, THAT HAVE MORE EIGHT ADJACENT SQUARE OF TUNEL OR ROOM
--IF SO, CENTRAL TUNEL SQUARE IS REGISTERED
--IN THE END OF FUNCTION, ALL VALID TUNEL SQUARES ARE REMOVED AT ONCE
--
function correctTunels(map)
	local map=map
	local clearTab={}
	for i=1,#map do
    	for j=1,#map[i] do
            if map[i][j].tileID==tunel then
            	tileCount=0
            	for a=i-1,i+1 do
            		for b=j-1,j+1 do
            			if map[a][b].tileID==tunel or map[a][b].tileID==room then
            				tileCount=tileCount+1
            			end
            		end
            	end
            	if tileCount==9 then table.insert(clearTab,{i,j}) end
            end
        end
	end
	
	for k,v in ipairs(clearTab) do
		map[v[1]][v[2]].tileID=empty
	end
end


-->>>>>>> GENERATE EXITS <<<<<<<
--GENERATES ENTRANCE AND EXIT ON MAP
--WORK IN FOLLOWING STEPS:
--STEP1: INITIALIZE VARIABLES
--STEP2: START INFINITE OUTER LOOP
--STEP3: GENERATE ENTRANCE, CHOOSE RANDOM POSITION THAT IS EMPTY
--STEP4: CHECK FOUR SQUARES IN CROSS AND COUNT THEM IF TUNEL OR ROOM, REMEMBERS DIRECTION
--STEP5: IF COUNT==1 THEN VALID, WRITES TO MAP AND BREAK, OTHERWISE REPEAT
--STEP6: SAFETY COUNT, IF CYCLING FOR TOO LONG, REDUCE MINIMAL DISTANCE NEEDED
--STEP7: SAME AS PREVIOUS WHILE BUT ADD DISTANCE CHECK FOR EXIT
--STEP8: CONTROL SUMM OR REPEAT WHOLE GENERATION
--
function generateExits(map,minDistance)
	-->STEP1
	local minDistance=minDistance
	local map=map

	--random point
	local randPoint=function(map) return math.random(2,#map-1),math.random(2,#map[1]-1) end
	local rx,ry=randPoint(map)
	local tileCount=0
	local distance=0
	
	local done=0
	local innerCount=0
	local safetyCount=0
	local maxInnerCount=1000
	
	-->STEP2
	while true do
		--GENERATE ENTRANCE
		while true do
			-->STEP3
			rx,ry=randPoint(map)
			direction=""
			tileCount=0
			
			if map[rx][ry].tileID==empty then
				-->STEP4
				--TOP SQUARE	
				if map[rx-1][ry].tileID==tunel or map[rx-1][ry].tileID==room then
					tileCount=tileCount+1
					direction="N"
				end
			
				--BOTTOM SQUARE
				if map[rx+1][ry].tileID==tunel or map[rx+1][ry].tileID==room then
					tileCount=tileCount+1
					direction="S"
				end
			
				--LEFT SQUARE
				if map[rx][ry-1].tileID==tunel or map[rx][ry-1].tileID==room then
					tileCount=tileCount+1
					direction="W"
				end
			
				--RIGHT SQUARE
				if map[rx][ry+1].tileID==tunel or map[rx][ry+1].tileID==room then
					tileCount=tileCount+1
					direction="E"
				end
				
				-->STEP5
				if tileCount==1 then
					map[rx][ry].tileID=entrance 
					map.entrance={rx,ry,direction}
					done=done+1
					break
				else
					rx,ry=randPoint(map)
				end
			end
		end
	
		--GENERATE EXIT
		while true do
			-->STEP6
			safetyCount=safetyCount+1
			if safetyCount>=1000 then
				minDistance=minDistance-1
				print("minDistance reduced")
				safetyCount=0
			end
			
			rx,ry=randPoint(map)
			distance=math.sqrt((rx-map.entrance[1])^2+(ry-map.entrance[2])^2)
			direction=""
			tileCount=0
			-->STEP7
			if map[rx][ry].tileID==empty and distance>minDistance then
				--TOP SQUARE	
				if map[rx-1][ry].tileID==tunel or map[rx-1][ry].tileID==room then
					tileCount=tileCount+1
					direction="N"
				end
			
				--BOTTOM SQUARE
				if map[rx+1][ry].tileID==tunel or map[rx+1][ry].tileID==room then
					tileCount=tileCount+1
					direction="S"
				end
			
				--LEFT SQUARE
				if map[rx][ry-1].tileID==tunel or map[rx][ry-1].tileID==room then
					tileCount=tileCount+1
					direction="W"
				end
			
				--RIGHT SQUARE
				if map[rx][ry+1].tileID==tunel or map[rx][ry+1].tileID==room then
					tileCount=tileCount+1
					direction="E"
				end
				
				if tileCount==1 then
					map[rx][ry].tileID=exit
					map.exit={rx,ry,direction}
					done=done+1
					break
				else
					rx,ry=randPoint(map)
				end
			end
		end
	
	--STEP8
	if done==2 then break else done=0 end
	end
end


-->>>>>>> MAIN MAP GENERATOR FUNCTION <<<<<<<
--MAIN FUNCTION OF SET COMBINES ALL FUNCTION INTO GENERATING ORDER
--WORK IN FOLLOWING STEPS:
--STEP1: INITIALIZE VARIABLES
--STEP2: IF ROOM SIZE IS TOO LARGE, SHRINK SIZE TO ACCEPTABLE LIMITS
--STEP3: GENERATE NEW MAP WITH TUNELS UNTIL IT IS PROPERLY DISTRIBUTED
--STEP4: ADD ROOMS
--STEP5: EXPAND ROOMS A FEW TIMES, ACCORDIG TO SIZE OF MAP (1/2 AVR.LENGTH OF SIDE)
--STEP6: CORECT TUNELS, GENERATE EXITS AND IF NEEDED
--NOTE: ADD SPECIALS SHOULD BE DONE BASED ON LAYER THAT NEED TO BE COVERED
--RETURNS FINISHED MAP
--
function generateMap(width,height,minTunelLen,maxTunelLen,maxTunelCount,minRoomSize,maxRoomSize,maxRoomCount,exitDistance)
	-->STEP1
	local width=width
	local height=height
	local minTunelLen=minTunelLen
	local maxTunelLen=maxTunelLen
	local maxTunelCount=maxTunelCount
	local minRoomSize=minRoomSize
	local maxRoomSize=maxRoomSize
	local maxRoomCount=maxRoomCount
	local exitDistance=exitDistance
	
	-->STEP2
	if minRoomSize>(width+height)/10 then minRoomSize=math.floor((width+height)/10) end
	if maxRoomSize>(width+height)/6 then maxRoomSize=math.floor((width+height)/6) end
	
	-->STEP3
	isDistributed=false
	local mapa={}
	while not isDistributed do
		if DEBUG then print("Generate new map") end
		mapa=newMap(wid,hei)
		if DEBUG then print("Bordering new map") end
		addSides(mapa)
		if DEBUG then print("Generating tunels") end
		generateTunels(mapa,minTunelLen,maxTunelLen,maxTunelCount)
		if DEBUG then print("Checking tunel distribution") end
		isDistributed=distributedTunels(mapa,0.20)
	end
	
	-->STEP4
	if DEBUG then print("Generating rooms") end
	generateRooms(mapa,minRoomSize,maxRoomSize,maxRoomCount)

	-->STEP5
	if DEBUG then print("Expandind rooms") end
	for i=1,(wid+hei)/4 do
		expandRooms(mapa)
	end
	
	-->STEP6
	correctTunels(mapa)
	generateExits(mapa,(wid+hei)/4)
	--addSpecials(mapa)
	
	return mapa
end

--GENERATOR SYNTAX
--generateMap(width,height,minTunelLength,maxTunelLength,tunelCount,minRoomSize,maxRoomSize,roomCount,exitDistance)
map=generateMap(wid,hei,3,wid/2,(wid+hei)/2,3,6,(wid+hei)/4,(wid+hei)/4)

--PRINT MAP
printMap(map)
--print("Room count: " .. #map.roomList)
--print(table.unpack(map.entrance))
--print(table.unpack(map.exit))
--print("rooms: ")
--for k,v in ipairs(map.roomList) do print(table.unpack(v)) end