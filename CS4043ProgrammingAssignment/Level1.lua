--level1.lua
local composer = require("composer")

local scene = composer.newScene()

local function backToStart()


end

local physics  = require("physics")
physics.start()
physics.setGravity(0,0)

local lives = 3
local died = false
local livesText
local backGroup
local mainGroup
local uiGroup
local spawnTimer
local spawnedObjects = {}
local scrollSpeed = 2
local background
local background2

local spawnParams = {
xmin = 20,
xmax = 300,
yMin = 20,
yMax = 460,
spawnTime = 200,
spawnOnTimer = 12,
spawnInitial = 4
}

function scene:create(event)
  local sceneGroup = self.view

  physics.pause()

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect(backGroup,"Level1Background.png",1920,1080)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  background2 = display.newImageRect( backGroup , "Level1Background.png" , 1920 , 1080 )
  background2.x = display.contentCenterX
  background2.y  = display.contentCenterY

  livesText	= display.newText( uiGroup,"Lives: "..lives,160,80,"Font.ttf",108 )
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

local function spawnItem( bounds )

  local item =display.newItems ( 0, 0, 20 )

  item.x = math.random( bounds.xMin, bounds.xMax)
  item.y = math.random( bounds.yMin, bounds.yMax)

  spawnedObjects[#spawnedObjects+1] = item
end

local function spawnController( action, params )

  if (spawnTimer and ( action == "start" or action == "stop")) then
    timer.cancel( spawnTimer )
  end

  if ( action == "start" ) then

   local spawnBounds = {}
   spawnBounds.xMin = params.xMin or 0
   spawnBounds.xMax = params.xMax or display.contentWidth
   spawnBounds.yMin = params.yMin or 0
   spawnBounds.yMax = params.yMax or display.contentHeight

   local spawnTime = params.spawnTime or 1000
   local spawnOnTimer = params.spawnOnTimer or 50
   local spawnInitial = params.spawnInitial or 0

   if( SpawnInitial > 0 ) then
     for n = 1,spawnInitial do
       spawnItem( spawnBounds )
     end
   end

   if ( spawnOnTimer > 0 ) then
     spawnTimer = timer.performWithDelay( spawnTime,
     function() spawnItem( spawnBounds ); end, spawnOnTimer )
   end

   elseif (action == "pause") then
     timer.pause( spawnTimer )

   elseif ( action == "resume" ) then
     timer.resume( spawnTimer )
  end
end

local function bgScroll(event)
  background.x = background.x + scrollSpeed
  background2.x = background2.x + scrollSpeed

  if background.x == display.contentWidth * 1.5 then
    background.x = display.contentWidth*-.5
  end

  if background2.x == display.contentWidth * 1.5 then
    background2.x = display.contentWidth*-.5
  end

end

Runtime:addEventListener("enterFrame",bgScroll)

local function gameOver()
  if lives == 0 then

  end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
