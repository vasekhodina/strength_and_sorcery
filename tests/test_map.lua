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
function print_map(printable_map)
	for i=5,1,-1 do
		print(table.concat(printable_map[i]))
	end
	print("\n")
end

for i=0,3 do
	printable_map = map:getMapSquare(17,5,i,5)
	print_map(printable_map)
end

