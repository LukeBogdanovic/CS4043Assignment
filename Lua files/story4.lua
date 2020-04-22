local composer = require("composer")

local scene = composer.newScene()

local function goToMenu()
  composer.gotoScene( "menu" ,"fade" )
end
