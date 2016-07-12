-- Class for storing all regarding game Gui
-- Gui.lua
local Gui = {}

function Gui:echo(string, x_coord, y_coord)
	love.graphics.setFont(Gui.pixel_font)
	love.graphics.print(string, x_coord, y_coord, 0)
end

return Gui
