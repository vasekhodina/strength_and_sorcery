-- screen.lua
-- table for creation of different screens that have only text, like splash screen, end screen and so on
gui = require "Gui"
local Screen = {}

local text_x = 25
local text_y = 50
-- How long should the splash be visible
Screen.stay = 1
-- Variable for storing the showing of screen
Screen.show = false
-- Variable for storing name of screen
Screen.name = ""
Screen.text = ""

function Screen:new(name, text, stay) 
	Screen.name = name
	Screen.stime = love.timer.getTime()
	Screen.text = text
	Screen.stay = stay
	return Screen
end

function Screen:draw(stime) 
  gui:echo(Screen.text, text_x, text_y)
  if (love.timer.getTime() - Screen.stime) > Screen.stay then
    Screen.show = false
  end
end

return Screen
