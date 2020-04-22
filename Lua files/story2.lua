--story2.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToMenu()
  composer.gotoScene( "Level2" , "fade" )
end
