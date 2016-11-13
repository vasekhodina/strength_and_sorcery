local M = {}
conf = require "conf"
worldScreen = require "worldScreen"
ih = require "inputHandler"
party = require "party"
map = require "map"
game_debug = require "game_debug"
gui = require "gui"
splash = require "Splash"
screen = require "screen"
ws = 0

--- Override of love2d load function, mostly loading graphics + setting fonts and window size
function love.load()
	--init the window
	love.window.setTitle("Strength and Sorcery")
	love.window.setMode(320*conf.scale,200*conf.scale)
	love.graphics.setDefaultFilter('nearest','nearest')
	-- init debug font
	gui.font = love.graphics.newFont(14)
	love.graphics.setFont(Gui.font)
	--init game font
	gui.pixel_font = love.graphics.newFont("assets/fonts/lunchds.ttf")

	party = party:new(17,6,0,map.currentMap)

	ws = worldScreen:newWorldScreen(party,map.currentMap)
	gd = game_debug:new(party,worldScreen)
	item_list = 0
	game_start_time = love.timer.getTime()
	fin_screen = screen:new("Final screen", "Congratulations!\n", 5)
	game_timer = nil
	game_screen = love.graphics.newImage("assets/world/game_screen.png")
end

--- Override of love2d update function, in update function all of the game logic should be handled.
-- @param dt Delta time for update function, see gamedevelopmentpatterns.com for explanation
function love.update(dt)
	if party.getX() == 1 and party.getY() == 19 and fin_screen.show == false then
		fin_screen.show = true
		fin_screen:append("It took you " .. math.floor(love.timer.getTime() - game_timer) .. " seconds.")
		fin_screen:append("You can close the game now.")
	end
end

--- Separate function handling graphics drawing.
function love.draw()
	love.graphics.scale(conf.scale)
	if fin_screen.show then
		fin_screen:draw()
	elseif splash.show then
    	splash:draw(game_start_time)
		game_timer = love.timer.getTime()
    else
    	ws:drawWorldScreen()
	love.graphics.draw(game_screen)
    	game_debug.print_message()
  	end
end
return M
