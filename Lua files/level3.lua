--level3.lua
local composer = require("composer")
local ai = require("AI").newAI
local buff = require("buff")
local scene = composer.newScene()

local function backToStart()
  composer.gotoScene( "restart3" )
end

local function nextLevel()
  composer.gotoScene( "Story4" ,"fade" )
end

local physics  = require("physics")
physics.start()
physics.setGravity(0,60)

local jjLives = 3
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
local music =audio.loadSound( "music/FinalLevel.mp3" )
local musicChannel

function scene:create(event)
  composer.removeScene( "story3" )
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

local function musicPlay()
  musicChannel = audio.play( music ,{channel = 1, loops = -1} )
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

local function gameOver()
  if (lives == 0) then
    timer.cancel( ninjas )
    timer.cancel( ducks )
    timer.cancel( JJ )
    display.remove( "buff" )
    backToStart()
  end
end

local function finishLevel(event)
  if(jjLives == 0) then
    timer.cancel( ninjas )
    timer.cancel( ducks )
    timer.cancel( JJ )
    display.remove( "buff" )
    enemy:remove()
    enemy1:remove()
    composer.removeScene( "level3", false )
  end
end


buff.type = "player"

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
  enemy1.limitLeft = 1000
  enemy1.limitRight = 1000
  enemy1.stalker = true
  enemy1.lastPlayerNoticedPosition = buff.x
  function enemy1:defaultActionOnAiCollisionWithPlayer(event)
    if (event.other.type == "player" and spacePressed == true) then
       enemiesKilled = enemiesKilled + 1
       updateText()
  	   enemy1:remove( )
    end
  end

  function enemy:customActionOnAiCollisionWithPlayerEnd(event)
   if(event.other.type == "player" and spacePressed == false) then
     buff:pause()
     buff:setSequence("hurt")
     buff:play()
     lives = lives - 1
     updateText()
     gameOver()
     buff:setSequence("walk")
   end
  end
 end

   function enemy1:defaultActionOnVisualContactWithPlayer(event)
     if(event.other.type == "player") then
       enemy1:getPlayerPosition(buff)
       enemy1:moveObjToPlayerPosition()
     end
   end

  function enemy1:customActionOnAiCollisionWithObjects(event)
	 if(event.other.type == 'enemy') then
		  enemy1:SwitchDirection()
	 end
  end

  function enemy1:addExtraAction()
    if(rand == 3)then
      enemy1:setLinearVelocity(0,-200)
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

local ninjasprite = {ninjaSheet,ninjaseq}
function createNinjas()
  local enemy = ai({group = mainGroup,x =math.random(1920), y = 900, ai_type = "patrol",sprite = ninjasprite})
  enemy.limitLeft = 1000
  enemy.limitRight = 1000
  enemy.lastPlayerNoticedPosition = buff.x
  enemy.stalker = true

  function enemy:defaultActionOnVisualContactWithPlayer(event)
    if(event.other.type == "player") then
      JJ:getPlayerPosition(buff)
      JJ:moveObjToPlayerPosition()
    end

  function enemy:defaultActionOnAiCollisionWithPlayer(event)
    if (event.other.type == "player" and spacePressed == true) then
       enemiesKilled = enemiesKilled + 1
       updateText()
  	   enemy:remove()
    end
 end

 function enemy:customActionOnAiCollisionWithPlayerEnd(event)
   if(event.other.type == "player" and spacePressed == false) then
    enemy:setSequence("duckMelee")
    enemy:play()
    buff:pause()
    buff:setSequence("hurt")
    buff:play()
    lives = lives - 1
    updateText()
    gameOver()
   end
  end

  function enemy:customActionOnAiCollisionWithObjects(event)
	   if(event.other.type == "enemy") then
		  enemy:SwitchDirection()
	   end
  end

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

local JJSheet = graphics.newImageSheet( "img/hotdogsheet.png",  JJOptions )

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

local JJsprite = {JJSheet,JJseq}
function createJJ(event)
  local JJ = ai({group = mainGroup,x = math.random(1920),y=900,ai_type="boss",sprite = JJsprite})
  JJ.limitLeft = 1200
  JJ.limitRight = 1200
  JJ.lastPlayerNoticedPosition = buff.x
  JJ.stalker = true
  function JJ:defaultActionOnVisualContactWithPlayer(event)
    if(event.other.type == "player") then
      JJ:getPlayerPosition(buff)
      JJ:moveObjToPlayerPosition()
    end

  function JJ:defaultActionOnAiCollisionWithPlayer(event)
    if (event.other.type == "player" and spacePressed == true) then
       jjLives = jjLives - 1
       updateText()
  	   enemy:remove()
       finishLevel()
    end
  end

  function JJ:customActionOnAiCollisionWithPlayer(event)
    if(event.other.type == "player" and spacePressed == false) then
      lives = lives - 1
      updateText()
      gameOver()
    end
  end
end

ninjas = timer.performWithDelay( 5000, createNinjas ,-1 )
ducks = timer.performWithDelay( 7000, createDucks,-1 )
JJ = timer.performWithDelay(20000, createJJ, 3)
Runtime:addEventListener("key",spacePressed)
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
