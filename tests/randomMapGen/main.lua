--[[
LOVE2D MAIN FILE
basic draw and update functions
code for testing of custom rogue-like map generator
]]--
require "rmg"

function love.load()
	map = newEmptyMap(30,30)
end

function love.update(d)

end

function love.draw()
	drawMap(map)
end

function love.keypressed(key)
	if key=="escape" then love.event.quit() --exit program
	elseif key=="up" then
		map = newEmptyMap(30,30)
		addRandomRoom(map,5,5,20) --add random room
	end
end

function love.mousepressed(button,x,y)

end

function love.focus()

end
