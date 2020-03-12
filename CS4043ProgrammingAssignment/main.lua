-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

display.setStatusBar( display.HiddenStatusBar )

math.randomseed( os.time() )

local function gotoMenu()
  composer.gotoScene( "menu" )
end
