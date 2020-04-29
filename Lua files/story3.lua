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
local JJ

local buffLines = audio.loadSound( "voicelines/story3pt1.mp3" )
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
  audio.setVolume( .1, { channel = musicChannel2 } )
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
    time = 400,
    loopCount = 0,
    loopDirection = "forward"
  },
  {
    name = "grow",
    start = 4,
    count = 9,
    time = 500,
    loopCount = 1,
    loopDirection = "forward"
  }
}
JJ = display.newSprite( JJSheet, JJseq )
JJ.xScale=-1
JJ.x = 1800
JJ.y = 980
JJ:setSequence("grow")


local function buffVanish(event)
  buff.x = -9000
  buff.y = 0
  buff.xScale = 1
end

function buffAppear(event)
    buff.x = -190
    buff.y = 900
    buff.xScale = 1
    buff:play("walk"  )
    transition.to( buff, { time=6000,  x=800, y=900, } )
    buffLinesChannel = audio.play( buffLines,{channel=3, loops = 0})
    audio.setVolume( 1, { channel = buffLinesChannel } )
end


function buffstop (event)
  buff:pause()
  JJLinesChannel = audio.play( JJLines,{channel=4, loops = 0})
  audio.setVolume( 1, { channel = JJLinesChannel } )
end

function JJTransforms (event)
  transition.to( JJ, { time=500,  x=1800, y=400, } )
  JJ:play("grow")
end
function JJLands (event)
  JJ:setSequence("bigwalk")
  JJ:play("bigwalk")
  transition.to( JJ, { time=500,  x=1800, y=850, } )
end
function Buffleaves (event)
  buff:play("walk")
  buff.xScale=-1
  transition.to( buff, { time=1000,  x=-100, y=900, } )
  JJLines = audio.loadSound( "voicelines/story3pt3.mp3" )
  JJLinesChannel = audio.play( JJLines,{channel=5, loops = 0})
end

function JJChases (event)
  transition.to( JJ, { time=750,  x=-300, y=850, } )
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





  timer.performWithDelay( 1, buffVanish )
  timer.performWithDelay( 2000, buffAppear )
  timer.performWithDelay( 8000, buffstop )
  timer.performWithDelay( 10000, JJTransforms)
  timer.performWithDelay( 11000, JJLands)
  timer.performWithDelay( 19000, Buffleaves )
  timer.performWithDelay( 19000, JJChases)
  timer.performWithDelay( 7000, fadeMusic )
  timer.performWithDelay( 10500, newMusic )

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


  timer.performWithDelay( 20000,nextLevelAppear )
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
