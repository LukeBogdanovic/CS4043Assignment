--level1.lua
local composer = require("composer")
local buff = require("buff")
local duck = require("duck")
local hotDog = require("hotDog")
local Ninja = require("Ninja")
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0,60)
physics.setDrawMode("hybrid")

local lives = 3
local died = false
local whereFrom = math.random(2)
local livesText
local backGroup
local mainGroup
local uiGroup
local scrollSpeed = 2
local background
local background2
local pauseButton
local enemiesKilled = 0
local killed = enemiesKilled + 1
local music = audio.loadSound( "music/levelOne.mp3" )
local musicChannel

function scene:create(event)
  local sceneGroup = self.view

  physics.pause()

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect(backGroup,"img/Level1Background.png",1920,1080)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  background2 = display.newImageRect( backGroup , "img/Level1Background.png" , 1920 , 1080 )
  background2.x = display.contentCenterX+1920
  background2.y  = display.contentCenterY

  floor = display.newImageRect( backGroup, "img/floor.png",3840 ,100 )
  floor.y = 1080
  floor.x = display.contentCenterX
  floor.objType = "floor"
  physics.addBody( floor,"static",  {friction = 0.3,bounce = 0})

  physics.addBody( buff,"dynamic", {density =1,bounce=0} )

  musicChannel = audio.play( music, {channel = 1,loops = -1} )

  timer.performWithDelay( 7000,createDuck,-1 )

  livesText	= display.newText( uiGroup,"Lives: "..lives,160,80,"Font.ttf",108 )
end

local function updateText()
  livesText.text = "Lives: "..lives
end

local function bgScroll(event)
    background.x = background.x - scrollSpeed
    background2.x = background2.x - scrollSpeed

    if (background.x + 1920/2 < 0) then
      background.x = background.width*3/2-scrollSpeed
    end

    if (background2.x + 1920/2 < 0) then
      background2.x = background2.width*3/2-scrollSpeed
    end
end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  physics.start()

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
end

local function backToStart()
  composer.gotoScene( "restart" )
end

local function nextLevel()
  composer.gotoScene( "Story2" , "fade" )
end

local function gameOver(event)
  if lives == 0 then
    backToStart()
  end
end

local function backToBeginning(event)
  if died == true then
    deathText = display.newText( "YOU DIED" )
    if lives == lives-1 then
      composer.gotoScene("level1")
    end
  end
end

local function finishLevel()
  if (enemiesKilled == 15) then
    nextLevel()
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
    name = "duckwalk",
    start = 1,
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

local newDuck = display.newSprite(duckSheet,duckseq)
local ducks ={}
local i = 0

function createDuck()
  for i = 1,10 do
    ducks[i] = display.newSprite( duckSheet,duckseq  )
  if(whereFrom == 1)then
    ducks[i].x = -60
    ducks[i].y = buff.y
    ducks[i]:setSequence("duckwalk")
    if ((buff.x - ducks[i].x) >= 600) then
      ducks[i]:play()
      ducks[i]:setLinearVelocity(200,0)
    elseif((buff.x-ducks[i].x) < 600)then
      ducks[i]:play()
      ducks[i]:setLinearVelocity(100,0)
    end
  elseif(whereFrom == 2)then
    ducks[i].x = 1920+60
    ducks[i].y = buff.y
    if ((buff.x - ducks[i].x) >= 600) then
      ducks[i]:play()
      ducks[i]:setLinearVelocity(200,0)
    elseif((buff.x-ducks[i].x) < 600)then
      ducks[i]:play()
      ducks[i]:setLinearVelocity(100,0)
    end
  end
  end
end

Runtime:addEventListener("enterFrame",bgScroll)
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
