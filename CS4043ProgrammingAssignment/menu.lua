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

  local background = display.newImageRect(sceneGroup,"background1.png",800,1400)
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  local title = display.newImageRect( sceneGroup, "title.png", 500, 80 )
  title.x = display.contentCenterX
  title.y = 200

  local playButton = display.newText(sceneGroup, "play", display.contentCenterX,700,native.systemFont,44)
  playButton:setFillColor(0.82,0.86,1)

  playButton:addEventListener("tap",goToGame)
  optionsButton:addEventListener("tap",goToOptions)
end

function scene:show( event )

  local sceneGroup = self.view
  local phase  = event.phase

  if( phase == "will" ) then

  elseif ( phase == "did") then
 end
end

function scene:hide(event)

  local sceneGroup = self.view
  local phase = event.phase

  if( phase == "will" ) then

  elseif( phase == "did" ) then

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
