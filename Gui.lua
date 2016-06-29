-- Class for storing all regarding game Gui
-- Gui.lua
local Gui = {}

function Gui:echo(string, x_coord, y_coord, size)
	love.graphics.setFont(Gui.pixel_font)
	love.graphics.print(string, x_coord, y_coord, 0, size, size)

end

return Gui
