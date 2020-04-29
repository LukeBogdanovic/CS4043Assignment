--level1.lua
local composer = require("composer")
local buff = require("buff")
local ai = require("AI").newAI
local timers = require("timer").timer
local scene = composer.newScene()
local physics = require("physics")
physics.start()
physics.setGravity(0,60)
-- physics.setDrawMode("hybrid")

local lives = 3
local died = false
local livesText
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
local scrollSpeed = 2
local background
local background2
local enemiesKilled = 0
local killCounter
local music = audio.loadSound( "music/levelOne.mp3" )
local musicChannel
local sceneGroup = display.newGroup()

function scene:create(event)
  composer.removeScene("story1")
  sceneGroup = self.view

  physics.pause()

  sceneGroup:insert(backGroup)

  sceneGroup:insert(mainGroup)

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
  buff.isFixedRotation = true

  livesText	= display.newText( uiGroup,"Lives: "..lives,140,80,"Font.ttf",108 )
  killCounter = display.newText( uiGroup,"Killed: "..enemiesKilled,1760,80,"Font.ttf",108 )
end

local function updateText()
  livesText.text = "Lives: "..lives
  killCounter.text = "Killed:"..enemiesKilled
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
end

local function backToStart()
  composer.gotoScene( "restart" )
end

local function nextLevel()
  composer.gotoScene( "Story2" , "fade" )
end

local function gameOver()
  if (lives == 0) then
    lives = 3
    backToStart()
  end
end

local function finishLevel()
  if (enemiesKilled == 15) then
    timer.cancel( ninjas )
    Runtime:removeEventListener("enterFrame",bgScroll)
    nextLevel()
  end
end

buff.type = "player"

local ninjaOptions =
{
    width = 294,
    height = 294,
    numFrames = 4
}

local ninjaSheet = graphics.newImageSheet( "img/ninjaSheet.png",  ninjaOptions )

local ninjaseq = {
  {
    name = "ninjawalk",
    start = 1,
    count = 3,
    time = 413,
    loopCount = 0,
    loopDirection = "forward"
  },
  {
    name = "ninjaMelee",
    frames = {1,4},
    time = 413,
    loopCount = 1,
    loopDirection = "bounce"
  }
}

local ninjasprite = {ninjaSheet,ninjaseq}
function createNinjas()
  local enemy = ai({group = mainGroup,x =math.random(1920), y = 900, ai_type = "patrol",sprite = ninjasprite})
  enemy.limitLeft = 1000
  enemy.limitRight = 1000
  enemy.lastPlayerNoticedPosition = buff.x
  enemy.stalker = true
  function enemy:defaultActionOnAiCollisionWithPlayer(event)
    if (event.other.type == "player" and spacePressed == true) then
       enemiesKilled = enemiesKilled + 1
       updateText()
  	   enemy:remove()
       finishLevel()
     elseif(event.other.type == "player" and spacePressed == false)then
     lives = lives - 1
     updateText()
     gameOver()
   end
 end
end

function spacePressed(event)
  if (event.phase == "down") then
    if (event.keyName == "space") then
      spacePressed = true
    end
  elseif (event.phase == "up") then
    if (event.keyName == "space") then
      spacePressed = false
    end
  end
end

Runtime:addEventListener("key",spacePressed)
ninjas = timer.performWithDelay( 5000, createNinjas ,-1 )
Runtime:addEventListener("enterFrame",bgScroll)
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
