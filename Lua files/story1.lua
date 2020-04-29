--story1.lua
local composer = require( "composer" )

local scene = composer.newScene()
local buff = require("buff")

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
local music2 = audio.loadSound( "music/levelOne.mp3" )
local ClickButton
local ClickButtonChannel = audio.loadSound( "sounds/ClickButton.mp3" )
local chickenFilletRoll
local hotDog
local buffLines = audio.loadSound( "voicelines/Opening.mp3" )
local buffLinesChannel
local JJLines = audio.loadSound( "voicelines/JJstory1.mp3" )
local JJlinesChannel

local function fadeMusic(event)
  musicChannel1 = audio.fadeOut( music1,{ channel=1, time=1500  } )
end

local function newMusic(event)
  musicChannel2 = audio.play( music2,{channel =2, loops=-1} )
  audio.setVolume( .1, { channel = musicChannel2 } )
end

local function buffAppear(event)
  buff.x = -90
  buff.y = 900
  buff:play("walk")
  transition.to( buff, { time=25500,  x=1300, y=900, } )
  buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
  audio.setVolume( 1, { channel = buffLinesChannel } )
end

local function chickenFilletRollAppear(event)
  transition.to( chickenFilletRoll, { time=5000,  x=1600, y=950, } )
end

local function hotDogAppear(event)
  hotDog.x = 1665
  hotDog.y = 0
  transition.to( hotDog, { time=400,  x=1665, y=840, } )
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
  audio.setVolume( 1, { channel = JJLinesChannel } )
end

local function buffstop(event)
  buff:pause()
end

local function hotDogSteals(event)
  transition.to( hotDog, { time=500,  x=3000, y=900, } )
  transition.to( chickenFilletRoll, { time=500,  x=3000, y=900, } )
end

function scene:create( event )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  audio.setVolume( .1, { channel = musicChannel1 } )
  audio.setVolume( .1, { channel = musicChannel2 } )

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  chickenFilletRoll = display.newImageRect( "img/Chicken-Roll.png", 150, 150)
  chickenFilletRoll.x = 2000
  chickenFilletRoll.y = 950
  hotDog = display.newImageRect( "img/HotDogMoving.png", 150, 150)
  hotDog.xScale = -1
  hotDog.x = 1700
  hotDog.y = -75

  buff.x = -500
  buff.y = 500

  background = display.newImageRect( backGroup, "img/Level1Background.png", 1920, 1080 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  floor = display.newImageRect( backGroup, "img/floor.png",1920 , 100 )
  floor.x = display.contentCenterX
  floor.y = 1080
  timer.performWithDelay( 500,  buffAppear )
  timer.performWithDelay( 21500, chickenFilletRollAppear )
  timer.performWithDelay( 26000, buffstop )
  timer.performWithDelay( 35000, hotDogAppear)
  timer.performWithDelay( 56500, hotDogSteals)
  timer.performWithDelay( 34800, fadeMusic )
  timer.performWithDelay( 37500, newMusic )

  function nextLevelAppear()
    nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
    nextLevelButton.x = 1650
    nextLevelButton.y = 100
    nextLevelButtonText = display.newText( uiGroup,"START THE HUNT",1650,100,"font.ttf",108 )
    nextLevelButton:addEventListener("tap",Buttonclicked)
    nextLevelButton:addEventListener("tap",goToLevel)
  end


  timer.performWithDelay( 57000,nextLevelAppear )
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
