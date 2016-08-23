-- Class for storing all regarding game Gui
-- Gui.lua
local Gui = {}

--- Function that prints a message on screen with "artsy" game font, the font is set in mai.lua in load() function
-- @see main.lua
-- @param string The string that should be written
-- @param x The x screen coordinate of the first letter of message
-- @param y The y screen coordinate of the first letter of message
function Gui:echo(string, x, y)
	love.graphics.setFont(Gui.pixel_font)
	love.graphics.print(string, x, y, 0)
end

return Gui
