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
local ClickButton  = audio.loadSound( "sounds/ClickButton.mp3" )
local ClickButtonChannel = audio.loadSound( "sounds/ClickButton.mp3" )
local musicChannel1
local musicChannel2
local music1 = audio.loadSound( "music/levelOne.mp3" )
local music2 = audio.loadSound( "music/levelTwo.mp3" )
local JJ
local buffLines = audio.loadSound( "voicelines/story2pt1.mp3" )
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
  buff.x = -190
  buff.y = 900
  buff.xScale = 1
  buff:play("walk"  )
  transition.to( buff, { time=4000,  x=700, y=900, } )
  buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
  audio.setVolume( 1, { channel = buffLinesChannel } )
end

function buffstop (event)
  buff:pause()
end

function JJAppears(event)
  JJ.x = 2100
  JJ.y = 990
  JJ.xScale = -1
  JJ:play("walk")
  transition.to( JJ, { time=2000,  x=1750, y=990, } )
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
  audio.setVolume( 2, { channel = JJLinesChannel } )
end

function Bufftalks(event)
  buffLines = audio.loadSound( "voicelines/story2pt3.mp3" )
  buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
end

function JJLeavesBuffMoves (event)
  JJ.xScale = 1
  transition.to( JJ, { time=2500,  x=2800, y=990, } )
  buff:play("walk" )
  transition.to( buff, { time=2000,  x=1400, y=900, } )
end

function duckAppears (event)
  JJLines = audio.loadSound( "voicelines/story2pt4.mp3" )
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
  buff.xScale = -1
  transition.to( duck, { time=1000,  x=300, y=900, } )
  duck.xScale = -1
end
function buffrepliesone(event)
  buffLines = audio.loadSound( "voicelines/story2pt5.mp3" )
  buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
end

function ducktalksone(event)
  JJLines = audio.loadSound( "voicelines/story2pt6.mp3" )
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
end

function buffrepliestwo (event)
  buffLines = audio.loadSound( "voicelines/story2pt7.mp3" )
  buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
end
function ducktalkstwo(event)
  JJLines = audio.loadSound( "voicelines/story2pt8.mp3" )
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
end
function buffrepliesthree (event)
  buffLines = audio.loadSound( "voicelines/story2pt9.mp3" )
  buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
end


function buffAndDuckLeaves (event)
  JJLines = audio.loadSound( "voicelines/story2pt10.mp3" )
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
  JJ.xScale = 1
  buff.xScale = 1
  buff:play("walk"  )
  duck1.xScale = -1
  duck2.xScale = -1
  transition.to( buff, { time=3000,  x=3600, y=900, } )
  transition.to( duck, { time=3000,  x=3000, y=900, } )
  transition.to( duck1, { time=3000,  x=2700, y=900, } )
  transition.to( duck2, { time=3000,  x=2300, y=900, } )
end




local JJoptions =
{
    frames =
    {
        {   -- frame 1
            x = 0,
            y = 0,
            width = 69,
            height = 96
        },
        {   -- frame 2
            x = 72,
            y = 0,
            width = 69,
            height = 96
        },
        {   -- frame 3
            x =143,
            y = 0,
            width = 69,
            height = 96
        },
        {   -- frame 4 growing
            x = 214,
            y = 0,
            width = 90,
            height = 125
        },
        {   -- frame 5
            x = 306,
            y = 0,
            width = 120,
            height = 167
        },
        {   -- frame 6
            x = 428,
            y = 0,
            width = 150,
            height = 209
        },
        {   -- frame 7
            x = 580,
            y = 0,
            width = 180,
            height = 250
        },
        {   -- frame 8
            x = 762,
            y = 0,
            width = 210,
            height = 292
        },
        {   -- frame 9
            x = 974,
            y = 0,
            width = 240,
            height = 334
        },
        {   -- frame 10
            x = 1216,
            y = 0,
            width = 270,
            height = 376
        },
        {   -- frame 11
            x = 1488,
            y = 0,
            width = 300,
            height = 417
        },
        {   -- frame 12 grown
            x = 1790,
            y = 0,
            width = 330,
            height = 459
        },
        {   -- frame 13
            x = 2122,
            y = 0,
            width = 330,
            height = 459
        },
        {   -- frame 14
            x = 2454,
            y = 0,
            width = 330,
            height = 459
        }
    }
}

local JJSheet = graphics.newImageSheet( "img/hotdogsheet.png",  JJoptions )

local JJseq = {
  {
    name = "smallwalk",
    start = 1,
    count = 3,
    time = 413,
    loopCount = 0,
    loopDirection = "forward"
  },
  {
    name = "bigwalk",
    start = 12,
    count = 3,
    time = 800,
    loopCount = 0,
    loopDirection = "forward"
  },
  {
    name = "grow",
    start = 4,
    count = 9,
    time = 413,
    loopCount = 0,
    loopDirection = "forward"
  }
}

function scene:create( event )
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
  duck1 = display.newImageRect( "img/Duck-melee1.png", 275,275)
  duck1.x = -100
  duck1.y = 900
  duck2 = display.newImageRect( "img/Duck-melee1.png", 275,275)
  duck2.x = -200
  duck2.y = 900

  JJ = display.newSprite( JJSheet, JJseq )
  JJ.x = -500
  JJ.y = 0

  timer.performWithDelay( 1,  buffVanish )
  timer.performWithDelay( 2000,  buffAppear )
  timer.performWithDelay( 6000, buffstop )
  timer.performWithDelay( 5500, JJAppears )
  timer.performWithDelay( 13500, Bufftalks )
  timer.performWithDelay( 17500, JJLeavesBuffMoves )
  timer.performWithDelay( 19500, buffstop )



  timer.performWithDelay( 19500, duckAppears )
  timer.performWithDelay( 21500, buffrepliesone )
  timer.performWithDelay( 26500, ducktalksone )
  timer.performWithDelay( 30500, buffrepliestwo )
  timer.performWithDelay( 35500, ducktalkstwo )
  timer.performWithDelay( 38500, buffrepliesthree )
  timer.performWithDelay( 43500, buffAndDuckLeaves )




  --timer.performWithDelay( 28500, fadeMusic )
  --timer.performWithDelay( 30000, newMusic )

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
