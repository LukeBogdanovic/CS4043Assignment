local composer = require( "composer")

local scene = composer.newscene()






local function gotoGame()
  composer.gotoScene("game")

function scene:create(event )
  local sceneGroup = self.view

local background = display.newimageRect(sceneGroup, "xxx.png", 1080, 1920 )
background.x = display.contentCenterx
background.y = display.contentcenterY

local title = display.newImageRect()

end
