--level3.lua
local composer = require("composer")
local ai = require("AI").newAI
local buff = require("buff")
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

  physics.addBody( buff,"dynamic", {density =1,bounce=0} )
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

local function onHit(event)
  -- if()then
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

local duckSprite = {duckSheet,duckseq}
function createDucks()
  local enemy1 = ai({group = mainGroup,x =math.random(1920), y = 900, ai_type = "patrol",sprite = duckSprite})

  function enemy1:defaultActionOnAiCollisionWithPlayer(event)
    if (buff.buffPunch) then
  	   enemy1:remove( )
    end
 end

  function enemy1:customActionOnAiCollisionWithObjects(event)
	 if(event.other.type == 'enemy') then
		  enemy1:SwitchDirection()
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

buff.type = "player"

local ninjasprite = {ninjaSheet,ninjaseq}
function createNinjas()
  local enemy = ai({group = mainGroup,x =math.random(1920), y = 900, ai_type = "patrol",sprite = ninjasprite})

  function enemy:customActionOnAiCollisionWithPlayer(event)
    if (buff.buffPunch and event.phase) then
  	   enemy:remove( )
    end
 end

  function enemy:customActionOnAiCollisionWithObjects(event)
	 if(event.other.type == 'enemy') then
		  enemy:SwitchDirection()
	 end
  end
end

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

timer.performWithDelay( 5000, createNinjas ,-1 )
timer.performWithDelay( 7000, createDucks,-1 )
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
