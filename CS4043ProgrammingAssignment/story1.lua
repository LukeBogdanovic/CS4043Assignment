--story1.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToLevel()
  composer.gotoScene( "Level1","fade" )
end
