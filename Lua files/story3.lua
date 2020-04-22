--story3.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToLevel()
  composer.gotoScene( "level3" , "fade" )
end
