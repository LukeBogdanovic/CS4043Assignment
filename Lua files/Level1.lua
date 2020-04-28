--level1.lua
local composer = require("composer")
local buff = require("buff")
local ai = require("AI").newAI
local scene = composer.newScene()
local physics = require("physics")
physics.start()
physics.setGravity(0,60)
--physics.setDrawMode("hybrid")

local lives = 3
local died = false
local livesText
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
local scrollSpeed = 2
local background
local background2
local enemiesKilled = 13
local killCounter
local music = audio.loadSound( "music/levelOne.mp3" )
local musicChannel
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

  physics.addBody( buff,"dynamic", {density =1,bounce=0} )
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
  if (died == true) then
    deathText = display.newText( "YOU DIED" )
    enemiesKilled = enemiesKilled - 3
    if(enemiesKilled <= 3) then
      enemiesKilled = enemiesKilled
    elseif (enemiesKilled > 3 ) then
      enemiesKilled = enemiesKilled - 3
      died = false
    end
  end
end

local function finishLevel()
  if (enemiesKilled == 15) then
    display.remove( "buff" )
    composer.removeScene( "level1.lua", false )
    timer.cancel( createNinjas )
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
  local fPressed = false
  local enemy = ai({group = mainGroup,x =math.random(1920), y = 900, ai_type = "patrol",sprite = ninjasprite})
  enemy.limitLeft = 1000
  enemy.limitRight = 1000
  enemy.lastPlayerNoticedPosition = buff.x
  function enemy:defaultActionOnAiCollisionWithPlayer(event)
    if (event.other.type == "player" and fPressed == true) then
       enemiesKilled = enemiesKilled + 1
       updateText()
  	   enemy:remove()
       finishLevel()
    end
 end

 function enemy:customActionOnAiCollisionWithPlayerEnd(event)
   if(event.other.type == "player" and (enemy.x - buff.x) < 50 and event.phase == "ended")then
     buff:pause()
     buff:setSequence("hurt")
     buff:play()
     died = true
   end
 end

  function enemy:customActionOnAiCollisionWithObjects(event)
	   if(event.other.type == "enemy") then
		  enemy:SwitchDirection()
	   end
  end

  function enemy:addExtraAction()
    if(buff.buffPunch and (buff.x - enemy.x) < 50 and event.phase == "began") then
      if(event.contact.isTouching) then
      enemy:remove()
      end
    end
  end

  function fPresseda(event)
    if (event.phase == "down") then
      if (event.keyName == "f") then
        fPressed = true
      end
    elseif (event.phase == "up") then
      if (event.keyName == "f") then
        fPressed = false
      end
    end
  end

Runtime:addEventListener("key",fPressed)
end

timer.performWithDelay( 5000, createNinjas ,-1 )
Runtime:addEventListener("enterFrame",bgScroll)
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
