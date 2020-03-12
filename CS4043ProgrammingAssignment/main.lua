-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

display.setStatusBar( display.hiddenStatusBar )

math.randomseed( os.time() )

composer.gotoScene( "menu" )
