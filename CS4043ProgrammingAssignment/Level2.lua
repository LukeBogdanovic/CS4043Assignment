--level2.lua
local globalData = require ("globalData")

local composer = require("composer")

local scene = composer.newScene()

local physics  = require("physics")
physics.start()
physics.setGravity(0,0)

globalData.lives = 3
globalData.died = false
local livesText
local backGroup
local mainGroup
local uiGroup
local spawnTimer
local spawnedObjects = {}

local spawnParams = {
xmin = 20,
xmax = 300,
yMin = 20,
yMax = 460,
spawnTime = 200,
spawn on timer = 12,
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

  local background1 = display.newImageRect(backGroup,"background1.png",1920,1080)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local background1 = display.newImageRect( backGroup , "Level1Background1.png" , 1920 , 1080 )
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  livesText	= display.newText( uiGroup,"Lives: "..lives,200,80,native.systemFont,36 )

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
   local spawnOnTimer = or 50
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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
