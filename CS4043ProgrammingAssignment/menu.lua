-- menu.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToGame()
  composer.gotoScene( "game" )
end

local function goToOptions()
  composer.gotoScene("options")
end

function scene:create(event)
  local sceneGroup = self.view

  local background = display.newImageRect( sceneGroup , "background1.png" , 1920 , 1080 )
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  local title = display.newImageRect( sceneGroup, "title.png", 500, 80 )
  title.x = display.contentCenterX
  title.y = 200

  local playButton = display.newText( sceneGroup, "play", display.contentCenterX, 700 , native.systemFont,44 )
  playButton:setFillColor(0.82,0.86,1)

  local optionsButton = display.newText( sceneGroup, "options" , display.contentCenterX , 810 ,native.systemFont , 44 )
  optionsButton:setFillColor(0.75,0.78,1)

  playButton:addEventListener("tap", goToGame)
  optionsButton:addEventListener("tap", goToOptions)
end
