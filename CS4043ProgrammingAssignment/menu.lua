-- menu.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToGame()
  composer.gotoScene( "game" )
end

local function goToOptions()
  composer.gotoScene("options")
end

function scene:create( event )
  local sceneGroup = self.view

  local background1 = display.newImageRect( sceneGroup , "Level1Background1.png" , 1920 , 1080 )
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  local title = display.newImageRect( sceneGroup, "title.png", 500, 200 )
  title.x = display.contentCenterX
  title.y = 200

  local playButton = display.newImageRect( sceneGroup, filename, [baseDir,] width, height )
  playButton:setFillColor(0.82,0.86,1)

  local optionsButton = display.newImageRect( [parent,] filename, [baseDir,] width, height )
  optionsButton:setFillColor(0.75,0.78,1)

  local playText = display.newText( options )

  playButton:addEventListener("tap", goToGame)
  optionsButton:addEventListener("tap", goToOptions)
end

function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

  end
end

function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

  end
end

function scene:destroy( event )

  local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
