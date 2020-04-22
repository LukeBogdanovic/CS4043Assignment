--pause.lua
local composer = require("composer")

local scene = composer.newScene()

local pauseGroup

local function goToGame()
  composer.hideOverlay( "fade" , 400 )
end

function scene:create( event )
    local sceneGroup = self.view

    pauseGroup = display.newGroup()
    sceneGroup:insert( pauseGroup )

    local MenuBackground = display.newImageRect( pauseGroup, "Level1Background.png", display.actualContentWidth, display.actualContentHeight )
    MenuBackground.x = display.contentCenterX
    MenuBackground.y = display.contentCenterY

    local buttonBackToMenu = display.newText( pauseGroup, "Back To Menu", display.contentCenterX, 0.3*display.actualContentHeight, native.systemFont, 100 )
    buttonBackToMenu:setFillColor( 0, 0.294, 0.518 )
    buttonBackToMenu:addEventListener( "tap", gotoMenu )

    local buttonContinue = display.newText( pauseGroup, "Continue", display.contentCenterX, 0.35*display.actualContentHeight+50, native.systemFont, 100 )
    buttonContinue:setFillColor( 0, 0.294, 0.518 )
    buttonContinue:addEventListener( "tap", gotoGame )

    local
end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
  -- Code here runs when the scene is still off screen (but is about to come on screen)

  elseif ( phase == "did" ) then
  -- Code here runs when the scene is entirely on screen

 end
end

function scene:hide(event)
  local sceneGroup = self.view
  local pahse = event.phase
  local parent = event.parent

  if ( phase == "will" ) then
    parent:GameResume()
  elseif ( phase == "did" ) then

  end
end

function scene:destroy(event)
  local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
