--options.lua

local composer = new require("composer")

local scene = composer.newScene()

local function backToMain()
  composer.gotoScene( "menu" )
end

function scene:create( event )
  local sceneGroup = self.view

  local background = display.newImageRect( sceneGroup, "Level1Background1.png",1920,1080  )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local backButton = display.newRect( sceneGroup , display.contentCenterX , 540, 220, 80 )

  local backButtonText = display.newText( sceneGroup ,display.contentCenterX,  )
end 
