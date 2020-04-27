--level3.lua
local composer = require("composer")
local buff = require("buff")
local duck = require("duck")
local hotDog = require("hotDog")
local Ninja = require("Ninja")
local scene = composer.newScene()

local function backToStart()
  composer.gotoScene( "restart" )
end

local function nextLevel()
  composer.gotoScene( "Story4" ,"fade" )
end

local physics  = require("physics")
physics.start()
physics.setGravity(0,60)

local lives = 3
local died = false
local livesText
local backGroup
local mainGroup
local uiGroup
local scrollSpeed = 2
local background
local background2
local floor
local deathText
local enemiesKilled = 0

function scene:create(event)
  local sceneGroup = self.view

  physics.pause()

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect(backGroup,"img/Level3Background.png",1920,1080)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  background2 = display.newImageRect( backGroup , "img/Level3Background.png" , 1920 , 1080 )
  background2.x = display.contentCenterX+1920
  background2.y  = display.contentCenterY

  floor = display.newImageRect( backGroup, "img/floor.png",3840 ,100 )
  floor.y = 1080
  floor.x = display.contentCenterX
  floor.objType = "floor"
  physics.addBody( floor,"static",  {friction = 0.3,bounce = 0})

  physics.addBody( buff,"dynamic", {density =1,bounce=0},{box ={halfWidth=45,halfHeight=30 ,x=96,y=30},isSensor = true} )
  buff.isFixedRotation = true


  livesText	= display.newText( uiGroup,"Lives: "..lives,160,80,"Font.ttf",108 )
  killCounter = display.newText( uiGroup,"Killed: "..enemiesKilled,1760,80,"Font.ttf",108 )
end

local function updateKilled(event)
  enemiesKilled = enemiesKilled + 1
end

local function updateText()
  livesText.text = "Lives: "..lives
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

Runtime:addEventListener("enterFrame",bgScroll)

function createDuck(event)
    local whereFromDuck = math.random(2)
    ducks = display.newSprite( duckSheet,duckseq )
    physics.addBody( ducks, "dynamic" ,{density=1,bounce=0, radius= 125} )
    ducks.isFixedRotation = true
  if(whereFromDuck == 1)then
    ducks.x = -60
    ducks.y = 900
    ducks:setSequence("duckwalk")
    if ((buff.x - ducks.x) >= 600) then
      ducks:play()
      if not(died) then
        transition.to ( ducks, {time=3000,x=buff.x,y=900} )
      end
    elseif((buff.x-ducks.x) < 600)then
      ducks:play()
      if not(died) then
        transition.to ( ducks, {time=3000,x=buff.x,y=900} )
      end
    end
  elseif(whereFromDuck == 2)then
    ducks.x = 1920+60
    ducks.y = 900
    if ((buff.x - ducks.x) >= 600) then
        ducks:play()
      if not(died) then
        transition.to ( ducks, {time=3000,x=buff.x,y=900} )
      end
    elseif((buff.x-ducks.x) < 600)then
      ducks:play()
      if not(died) then
        transition.to ( ducks, {time=3000,x=buff.x,y=900} )
      end
    end
  end
end

local function onHit(event)
  -- if()then
end
timer.performWithDelay( 5000, createDuck ,-1 )

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

function createNinja(event)
    local whereFromNinja = math.random(2)
    ninjas = display.newSprite( ninjaSheet,ninjaseq )
    physics.addBody( ninjas, "dynamic" ,{density=1,bounce=0, radius= 147} )
    ninjas.isFixedRotation = true
  if(whereFromNinja == 1)then
    ninjas.x = -60
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
    ninjas.x = 1920+60
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
end

timer.performWithDelay( 7000, createNinja ,-1 )


local function gameOver()
  if (lives == 0) then
    backToStart()
  end
end

local function backToBeginning(event)
  if died == true then
    deathText = display.newText( "YOU DIED" )
    if lives == lives-1 then
      composer.gotoScene("Level3")
    end
  end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
