-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

display.setStatusBar( display.hiddenStatusBar )

math.randomseed( os.time() )

local function gotoMenu()
  composer.gotoScene( "menu" )
end
