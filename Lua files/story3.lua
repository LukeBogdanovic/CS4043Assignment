--story3.lua
local composer = require("composer")
local scene = composer.newScene()
local buff = require("buff")

local function goToLevel()
  composer.gotoScene( "level3" , "fade" )
end

local backGroup
local mainGroup
local uiGroup
local background
local nextLevelButton
local nextLevelButtonText
local floor
local ClickButton
local ClickButtonChannel = audio.loadSound( "sounds/ClickButton.mp3" )
local music = audio.loadSound( "music/LevelTwo.mp3" )
local music2 = audio.loadSound( "music/FinalLevel.mp3" )
local musicChannel2

function Buttonclicked (event)
  audio.setVolume( .5, { channel= ClickButtonChannel } )
  ClickButtonChannel = audio.play( ClickButton,{channel=2, loops = 0})
end

local function fadeMusic(event)
  musicChannel1 = audio.fadeOut( music1,{ channel=1, time=1500  } )
end

local function newMusic(event)
  musicChannel2 = audio.play( music2,{channel =2, loops=-1} )
end

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

  timer.performWithDelay( 6000, fadeMusic )

  function nextLevelAppear()
    nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 750, 400 )
    nextLevelButton.x = 1600
    nextLevelButton.y = 100
    nextLevelButtonText = display.newText( uiGroup,"FINISH THE MISSION",1600,100,"font.ttf",108 )
    nextLevelButton:addEventListener("tap",Buttonclicked)
    nextLevelButton:addEventListener("tap",goToLevel)
  end
  timer.performWithDelay( 15000,nextLevelAppear )
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
    composer.removeScene( "Story3", false)
  end
end

function scene:destroy( event )
  local sceneGroup = self.view
  audio.dispose( music )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
