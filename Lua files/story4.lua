local composer = require("composer")
local scene = composer.newScene()
local buff = require("buff")

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
local ClickButton = audio.loadSound( "sounds/ClickButton.mp3" )
local ClickButtonChannel
local music = audio.loadSound( "music/FinalLevel.mp3" )
local musicChannel

local buffLines = audio.loadSound( "voicelines/story4.mp3" )
local buffLinesChannel
local JJLines = audio.loadSound( "voicelines/JJstory4.mp3" )
local jjLinesChannel

function Buttonclicked (event)
  audio.setVolume( .5, { channel= ClickButtonChannel } )
  ClickButtonChannel = audio.play( ClickButton,{channel=2, loops = 0})
end

local function newMusic(event)
  musicChannel = audio.play( music2,{channel =1, loops=-1} )
end




local function buffVanish(event)
  buff.x = -9000
  buff.y = 0
  buff.xScale = 1
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
    nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
    nextLevelButton.x = 1650
    nextLevelButton.y = 100
    nextLevelButtonText = display.newText( uiGroup,"MISSION ACCOMPLISHED",1650,100,"font.ttf",108 )
    nextLevelButton:addEventListener("tap",Buttonclicked)
    nextLevelButton:addEventListener("tap",goToMenu)
  end

  timer.performWithDelay( 1,  buffVanish )


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
