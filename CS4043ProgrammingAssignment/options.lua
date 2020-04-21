--options.lua
local composer = new require("composer")

local scene = composer.newScene()

local function backToMain()
  composer.gotoScene( "menu" )
end

local backGroup
local uiGroup

function scene:create( event )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  local background = display.newImageRect( backGroup, "Level1Background.png",1920,1080  )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local backButton = display.newImageRect( uiGroup , display.contentCenterX , 540, 220, 80 )
  backButton.x = display.contentCenterX
  backButton.y = 900

  local backButtonText = display.newText( uiGroup ,"Back To Main",display.contentCenterX-25,900,"Font.ttf",108 )
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

return scene
