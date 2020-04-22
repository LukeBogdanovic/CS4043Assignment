--story1.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToLevel()
  composer.gotoScene( "Level1","fade" )
end

local backGroup
local mainGroup
local uiGroup
local background
local nextLevelButton
local nextLevelButtonText
local floor
local musicChannel1
local musicChannel2
local music1 = audio.loadSound( "music/Menu.mp3" )
local music2 = audio.loadSound( "music/Level1.mp3" )
local ClickButton
local ClickButtonChannel = audio.loadSound( "sounds/ClickButton.mp3" )

local function fadeMusic(event)
  musicChannel = audio.fadeOut( { channel=1, time=1500  } )
end

function scene:create( event )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect( backGroup, "img/Level1Background.png", 1920, 1080 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  floor = display.newImageRect( backGroup, "img/floor.png",1920 , 100 )
  floor.x = display.contentCenterX
  floor.y = 1080

  nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
  nextLevelButton.x = 1650
  nextLevelButton.y = 100

  nextLevelButtonText = display.newText( uiGroup,"Next Level",1650,100,"font.ttf",108 )

  nextLevelButton:addEventListener("tap",goToLevel)
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
     composer.removeScene( "story1" )
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
