local M = {}
worldScreen = require "worldScreen"
ih = require "inputHandler"
Party = require "Party"
map = require "map"
game_debug = require "game_debug"
ws = 0

-- Configure the game window
function love.conf(t)
	t.modules.joystick=false
	t.modules.physics=false
end

-- Load some default values for our rectangle.
function love.load()
	love.window.setTitle("Strength and Sorcery")
	love.window.setMode(1024,720)
	love.graphics.setDefaultFilter('nearest','nearest')
	font = love.graphics.newFont(14)
	love.graphics.setFont(font)
	party = Party:newParty(17,6,0)
	print(party:getX())
	ws = worldScreen:newWorldScreen(party,map.currentMap)
	gd = game_debug:new(party,worldScreen)
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
	ws:drawWorldScreen()
	love.graphics.rectangle("line",0,0,904,552)
	game_debug.print_message()
end
return M
