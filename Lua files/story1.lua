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

local function fadeMusic(event)
  musicChannel1 = audio.fadeOut( music1,{ channel=1, time=1500  } )
end

local function newMusic(event)
  musicChannel2 = audio.play( music2,{channel =2, loops=-1} )
end

local function buffAppear(event)
  buff.x = -90
  buff.y = 900
  buff:play("walk")
  transition.to( buff, { time=9500,  x=800, y=900, } )
end

local function chickenFilletRollAppear(event)
  transition.to( chickenFilletRoll, { time=5000,  x=1600, y=950, } )
end

local function hotDogAppear(event)
  hotDog.x = 1700
  hotDog.y = 0
  transition.to( hotDog, { time=500,  x=1700, y=900, } )
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
  timer.performWithDelay( 6000, chickenFilletRollAppear )
  timer.performWithDelay( 10000, buffstop )
  timer.performWithDelay( 11000, hotDogAppear)
  timer.performWithDelay( 14500, hotDogSteals)
  timer.performWithDelay( 11000, fadeMusic )
  timer.performWithDelay( 11500, newMusic )

  function nextLevelAppear()
    nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
    nextLevelButton.x = 1650
    nextLevelButton.y = 100
    nextLevelButtonText = display.newText( uiGroup,"Next Level",1650,100,"font.ttf",108 )
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

  end
end

function scene:destroy( event )
  local sceneGroup = self.view
  audio.dispose( music )
  composer.removeScene( "story1", false )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
