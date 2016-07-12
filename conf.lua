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
function love.conf(t)
	t.modules.joystick=false
	t.modules.physics=false
	t.identity = "sas"									-- The name of the save directory (string)
	t.version = "0.10.1"                -- The LÖVE version this game was made for (string)
	t.console = false
end

return Conf
