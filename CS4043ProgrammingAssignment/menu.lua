-- menu.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToGame()
  composer.gotoScene( "Level1", {time=800, effect="crossFade"} )
end

local function goToOptions()
  composer.gotoScene("options",{time=800,effect="crossFade"})
end

local backGroup
local uiGroup

function scene:create( event )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert( backGroup )

  uiGroup = display.newGroup()
  sceneGroup:insert( uiGroup )

  local background = display.newImageRect( backGroup , "Level1Background.png" , 1920 , 1080 )
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  local title = display.newImageRect( backGroup, "title.png", 600, 300 )
  title.x = display.contentCenterX
  title.y = 200

  local playButton = display.newImageRect( uiGroup, "Button.png",  600, 400 )
  playButton.x = display.contentCenterX - 25
  playButton.y = 450

  local optionsButton = display.newImageRect( uiGroup, "Button.png", 600, 400 )
  optionsButton.x = display.contentCenterX - 25
  optionsButton.y = 750

  local playText = display.newText( uiGroup,"Play",display.contentCenterX-25,450,"Font.ttf",108 )

  local optionsText = display.newText( uiGroup,"Options",display.contentCenterX-25,750,"Font.ttf",108 )
  
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
