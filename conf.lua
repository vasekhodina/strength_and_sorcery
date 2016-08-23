--
--------------------------------------------------------------------------------
--         File:  conf.lua
--
--  Description:  Configuration of strength and sorcery game
--
-- Requirements:  ---
--        Notes:  ---
--       Author:  Vasek Hodina(Escaron), <vasek.hodina@gmail.com>
--      Created:  12.7.2016
--     Revision:  ---
--------------------------------------------------------------------------------
--
local Conf = {}
Conf.scale = 4

--- Function taking care of love2d engine configuration, no game related configs here.
-- @param t table containing love2d configurations, mandatory
function love.conf(t)
	t.modules.joystick=false
	t.modules.physics=false
	t.identity = "sns"									-- The name of the save directory (string)
	t.version = "0.10.1"                -- The LÖVE version this game was made for (string)
	t.console = false
end

return Conf
