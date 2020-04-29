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
local ClickButton = audio.loadSound( "sounds/ClickButton.mp3" )
local ClickButtonChannel
local music = audio.loadSound( "music/LevelTwo.mp3" )
local music2 = audio.loadSound( "music/FinalLevel.mp3" )
local musicChannel1
local musicChannel2

local buffLines = audio.loadSound( "voicelines/story3.mp3" )
local buffLinesChannel
local JJLines = audio.loadSound( "voicelines/JJstory3.mp3" )
local JJlinesChannel

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

local function buffVanish(event)
  buff.x = -9000
  buff.y = 0
  buff.xScale = 1
end

function buffAppear(event)
    physics.pause()
    buff.x = -190
    buff.y = 900
    buff.xScale = 1
    buff:play("walk"  )
    transition.to( buff, { time=3500,  x=800, y=900, } )
    buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
    audio.setVolume( 1, { channel = buffLinesChannel } )
end


function buffstop (event)
  buff:pause()
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
  audio.setVolume( 1, { channel = JJLinesChannel } )
end

function hotDogTransforms (event)

end

function hotDogLeaves (event)
    hotDog.xScale = 1
    transition.to( hotDog, { time=2500,  x=2800, y=920, } )
end

function BuffChases (event)
  buff:play("walk")
  transition.to( buff, { time=1500,  x=2800, y=920, } )
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

  hotDog = display.newImageRect( "img/HotDogMoving.png", 300, 300)
  hotDog.x =1800
  hotDog.y = 920
  hotDog.xScale =-1


  timer.performWithDelay( 1, buffVanish )
  timer.performWithDelay( 2000, buffAppear )
  timer.performWithDelay( 5560, buffstop )
  timer.performWithDelay( 9500, hotDogTransforms)
  timer.performWithDelay( 15000, hotDogLeaves)
  timer.performWithDelay( 17000, BuffChases )
  timer.performWithDelay( 7000, fadeMusic )
  timer.performWithDelay( 9500, newMusic )

  function nextLevelAppear()
    composer.removeScene( "level2")
    nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 750, 400 )
    nextLevelButton.x = 1600
    nextLevelButton.y = 100
    nextLevelButtonText = display.newText( uiGroup,"FINISH THE MISSION",1600,100,"font.ttf",108 )
    nextLevelButton:addEventListener("tap",Buttonclicked)
    nextLevelButton:addEventListener("tap",goToLevel)
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
