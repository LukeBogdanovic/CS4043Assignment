local composer = require("composer")

local scene = composer.newScene()

local function goToMenu()
  composer.gotoScene( "menu" ,"fade" )
end

local backGroup
local mainGroup
local uiGroup
local background
local nextLevelButton
local nextLevelButtonText
local floor

function scene:create( event )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect( backGroup, "img/Level3Background.png", 1920, 1080 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  floor = display.newImageRect( backGroup, "img/floor.png",1920 , 100 )
  floor.x = display.contentCenterX
  floor.y = 1080

  nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
  nextLevelButton.x = display.contentCenterX
  nextLevelButton.y = 200

  nextLevelButtonText = display.newText( uiGroup,"Back To Main Menu",1750,200,"font.ttf",108 )

  nextLevelButton:addEventListener("tap",goToMenu)
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
    composer.removeScene( "story4", shouldRecycle )

  end
end

function scene:destroy( event )

  local sceneGroup = self.view

end