local M = {}
worldScreen = require "worldScreen"
ih = require "inputHandler"
party = require "party"
map = require "map"
game_debug = require "game_debug"

-- Configure the game window
function love.conf(t)

	t.modules.joystick=false
	t.modules.physics=false
end

-- Load some default values for our rectangle.
function love.load()
	love.window.setTitle("Sword and Sorcery(work title)")
	love.window.setMode(1024,720)
	love.graphics.setDefaultFilter('nearest','nearest')
	font = love.graphics.newFont(14)
	love.graphics.setFont(font)
	worldScreen.loadWorldScreen()

end

-- Increase the size of the rectangle every frame.
function love.update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
	worldScreen.drawWorldScreen(party,map)
	love.graphics.rectangle("line",0,0,904,552)
	game_debug.print_message()
end
return M
