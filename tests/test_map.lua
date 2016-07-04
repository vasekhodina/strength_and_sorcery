--
--------------------------------------------------------------------------------
--         File:  test_map.lua
--
--        Usage:  ./test_map.lua
--
--  Description:  File for testing map.lua for Strength and Sorcery game
--
--      Options:  none
-- Requirements:  none
--         Bugs:  none yet found
--        Notes:  ---
--       Author:  Vaclav Hodina (Escaron),<vasek.hodina@gmail.com>
-- Organization:  N/A
--      Version:  1.0
--      Created:  4.7.2016
--     Revision:  001
--------------------------------------------------------------------------------
--
package.path = package.path .. ";../?.lua"
map = require"map"
printable_map = map:getMapSquare(17,5,5,0)
for i=1,5 do
  print(table.concat(printable_map[i]))
end
