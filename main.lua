local M = {}
conf = require "conf"
worldScreen = require "worldScreen"
ih = require "inputHandler"
Party = require "Party"
map = require "map"
game_debug = require "game_debug"
gui = require "Gui"
splash = require "Splash"
screen = require "screen"
ws = 0

-- Load some default values for our rectangle.
function love.load()
	--init the window
	love.window.setTitle("Strength and Sorcery")
	love.window.setMode(1024,720)
	love.graphics.setDefaultFilter('nearest','nearest')
	-- init debug font
	gui.font = love.graphics.newFont(14)
	love.graphics.setFont(Gui.font)
	--init game font
	gui.pixel_font = love.graphics.newFont("assets/fonts/lunchds.ttf")

	party = Party:new(17,6,0,map.currentMap)

	ws = worldScreen:newWorldScreen(party,map.currentMap)
	gd = game_debug:new(party,worldScreen)
	item_list = 0
  game_start_time = love.timer.getTime()
	fin_screen = screen:new("Final screen", "Congratulations!", 5)
end

function love.update(dt)
	if party.getX() == 1 and party.getY() == 19 then
		fin_screen.show = true
	end
end

function love.draw()
	love.graphics.scale(conf.scale)
	if fin_screen.show then
		fin_screen.draw()
	elseif splash.show == true then
    splash:draw(game_start_time)
  else
    ws:drawWorldScreen()
    love.graphics.rectangle("line",0,0,225,137)
    game_debug.print_message()
  end
end
return M
