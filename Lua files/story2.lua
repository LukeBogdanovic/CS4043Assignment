--story2.lua
local composer = require( "composer" )
local scene = composer.newScene()
local buff = require("buff")

local function goToLevel()
  composer.gotoScene( "Level2" , "fade" )
end

local backGroup
local mainGroup
local uiGroup
local background
local nextLevelButton
local nextLevelButtonText
local floor
local duckSheet
local ClickButton  = audio.loadSound( "sounds/ClickButton.mp3" )
local ClickButtonChannel = audio.loadSound( "sounds/ClickButton.mp3" )
local musicChannel1
local musicChannel2
local music1 = audio.loadSound( "music/levelOne.mp3" )
local music2 = audio.loadSound( "music/levelTwo.mp3" )

local buffLines = audio.loadSound( "voicelines/story2.mp3" )
local buffLinesChannel
local JJLines = audio.loadSound( "voicelines/JJstory2.mp3" )
local JJlinesChannel

function Buttonclicked (event)
  audio.setVolume( .5, { channel= ClickButtonChannel } )
  ClickButtonChannel = audio.play( ClickButton,{channel=5, loops = 0})
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
local function buffAppear(event)
  physics.pause()
  buff.x = -190
  buff.y = 900
  buff.xScale = 1
  buff:play("walk"  )
  transition.to( buff, { time=9500,  x=700, y=900, } )
  buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
  audio.setVolume( 1, { channel = buffLinesChannel } )
end

function buffstop (event)
  buff:pause()
end

function hotDogAppears(event)
  hotDog.x = 2100
  hotDog.y = 920
  hotDog.xScale = -1
  transition.to( hotDog, { time=3000,  x=1800, y=920, } )
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
  audio.setVolume( 1, { channel = JJLinesChannel } )
end

function hotDogLeavesBuffMoves (event)
  hotDog.xScale = 1
  transition.to( hotDog, { time=2500,  x=2800, y=920, } )
  buff:play("walk"  )
  transition.to( buff, { time=2000,  x=1400, y=900, } )
end

function duckAppears (event)
  buff.xScale = -1
  transition.to( duck, { time=1000,  x=300, y=900, } )
  duck.xScale = -1
end

function buffAndDuckLeaves (event)
  hotDog.xScale = 1
  buff.xScale = 1
  buff:play("walk"  )
  transition.to( buff, { time=3000,  x=3600, y=900, } )
  transition.to( duck, { time=3000,  x=2600, y=900, } )
end






function scene:create( event )
  composer.removeScene( "level1" )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect( backGroup, "img/level2Background.png", 1920, 1080 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  floor = display.newImageRect( backGroup, "img/floor.png",1920 , 100 )
  floor.x = display.contentCenterX
  floor.y = 1080

  duck = display.newImageRect( "img/Duck-melee1.png", 275,275)
  duck.x = -100
  duck.y = 900

  hotDog = display.newImageRect( "img/HotDogMoving.png", 300, 300)
  hotDog.x = -500
  hotDog.y = 0

  timer.performWithDelay( 1,  buffVanish )
  timer.performWithDelay( 2000,  buffAppear )
  timer.performWithDelay( 11500, buffstop )
  timer.performWithDelay( 9500, hotDogAppears )
  timer.performWithDelay( 15500, hotDogLeavesBuffMoves )
  timer.performWithDelay( 17500, buffstop )
  timer.performWithDelay( 17500, duckAppears )
  timer.performWithDelay( 20000, buffAndDuckLeaves )

  timer.performWithDelay( 18500, fadeMusic )
  timer.performWithDelay( 19000,newMusic )

  function nextLevelAppear()
    nextLevelButton = display.newImageRect( uiGroup, "img/Button.png", 700, 400 )
    nextLevelButton.x = 1650
    nextLevelButton.y = 100
    nextLevelButtonText = display.newText( uiGroup,"PURSUE CULLENS",1625,100,"font.ttf",108 )
    nextLevelButton:addEventListener("tap",Buttonclicked)
    nextLevelButton:addEventListener("tap",goToLevel)
  end
  timer.performWithDelay( 23000,nextLevelAppear )
end

function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

  end
end

local duckOptions =
{
    width = 320,
    height = 320,
    numFrames = 4
}

local duckSheet = graphics.newImageSheet( "img/ducksheetlarge.png",  duckOptions )

local duckseq = {
  {
    start = 1,
    name = "duckwalk",
    count = 3,
    time = 413,
    loopCount = 0,
    loopDirection = "forward"
  },
  {
    name = "duckMelee",
    frames = {1,4},
    time = 413,
    loopCount = 1,
    loopDirection = "bounce"
  }
}


function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then
    composer.removeScene( "Story2", false)
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
