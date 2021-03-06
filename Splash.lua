-- map.lua the class with functions and variables uded with maps
-- Splash.lua
gui = require "gui"
local Splash = {}

local text_x = 25
local text_y = 50
-- How long should the splash be visible
local stay = 10
Splash.show = true

function Splash:draw(stime) 
  gui:echo("Welcome to the Dungeon.\nHow fast can you find the exit?\nUse cursor keys to move and look around.", text_x, text_y)
  if (love.timer.getTime() - stime) > stay then
    Splash.show = false
  end
end

return Splash
