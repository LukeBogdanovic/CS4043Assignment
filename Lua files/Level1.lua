--level1.lua
local composer = require("composer")
local buff = require("buff")
local Ninja = require("Ninja").newAI
local newAI = require("AI").newAI
local scene = composer.newScene()
local physics = require("physics")
physics.start()
physics.setGravity(0,60)
physics.setDrawMode("hybrid")

local lives = 3
local died = false
local livesText
local hit = false
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
local sensorOverlaps = 0
local sceneGroup = display.newGroup()

function scene:create(event)
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

  physics.addBody( buff,"dynamic", {density =1,bounce=0},{box ={halfWidth=45,halfHeight=30 ,x=96,y=30},isSensor = true} )
  buff.isFixedRotation = true

  musicChannel = audio.play( music, {channel = 1,loops = -1} )

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
  audio.dispose( music )
  composer.removeScene( "level1", false )
end

local function backToStart()
  composer.gotoScene( "restart" )
end

local function nextLevel()
  composer.gotoScene( "Story2" , "fade" )
end

local function gameOver(event)
  if (lives == 0) then
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

local function killEnemy(self,event)
  if(buff.buffPunch and event.other.type == "ninjas")then
    if(event.phase == "began")then
      display.remove( ninjas )
      enemiesKilled = enemiesKilled+1
    end
  end
end

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

local sprite ={ninjaSheet,ninjaseq}
local enemy = newAI({group = mainGroup, img = "img/1.png", x =1560, y = buff.y, ai_type = "patrol",sprite = sprite})
enemy.stalker = true
enemy.limitLeft = 1200
enemy.visionLength = 1200

function enemy:defaultActionOnAiCollisionWithPlayer(event)
  	 enemy:remove( )
end
--[[    ninjas.isFixedRotation = true
  if(whereFromNinja == 1)then
    ninjas.x = -80
    ninjas.y = 900
    ninjas:setSequence("ninjawalk")
    if ((buff.x - ninjas.x) >= 600) then
      ninjas:play()
      if not(died) then
        transition.to ( ninjas, {time=3000,x=buff.x,y=900} )
      end
    elseif((buff.x-ninjas.x) < 600)then
      ninjas:play()
      if not(died) then
        transition.to ( ninjas, {time=3000,x=buff.x,y=900} )
      end
    end
  elseif(whereFromNinja == 2)then
    ninjas.x = 1920+80
    ninjas.y = 900
    if ((buff.x - ninjas.x) >= 600) then
        ninjas:play()
      if not(died) then
        transition.to ( ninjas, {time=3000,x=buff.x,y=900} )
      end
    elseif((buff.x-ninjas.x) < 600)then
      ninjas:play()
      if not(died) then
        transition.to ( ninjas, {time=3000,x=buff.x,y=900} )
      end
    end
  end
end]]--

function ninjaAttack(event)
  if(buff.x-ninjas.x < 50)then
    ninjas:pause()
    ninjas:setSequence("ninjaMelee")
    ninjas:play()
  end
end

sceneGroup:insert(mainGroup)
-- timer.performWithDelay( 7000, createNinja ,0 )
Runtime:addEventListener("collision",killEnemy)
Runtime:addEventListener("enterFrame",bgScroll)
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
