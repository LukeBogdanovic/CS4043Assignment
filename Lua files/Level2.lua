--level2.lua
local composer = require("composer")

local scene = composer.newScene()

local function backToStart()
  composer.gotoScene( "restart" )
end

local function nextLevel()
  composer.gotoScene( "Story3" ,"fade" )
end

local physics = require("physics")
physics.start()
physics.setGravity(0,30)
physics.setDrawMode("hybrid")

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
local pauseButton
local floor
local enemiesKilled = 0

local function updateKilled(event)
  enemiesKilled = enemiesKilled + 1
end

function scene:create(event)
  local sceneGroup = self.view

  physics.pause()

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect(backGroup,"img/Level2Background.png",1920,1080)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  background2 = display.newImageRect( backGroup , "img/Level2Background.png" , 1920 , 1080 )
  background2.x = display.contentCenterX+1920
  background2.y  = display.contentCenterY

  floor = display.newImageRect( backGroup, "img/floor.png",1920 ,100 )
  floor.y = 1080
  floor.x = display.contentCenterX

  livesText	= display.newText( uiGroup,"Lives: "..lives,160,80,"Font.ttf",108 )
  KilledText = display.newText( uiGroup,"EnemiesKilled: "..enemiesKilled, )
end

local function updateText()
  livesText.text = "Lives: "..lives
  killedText.text = "EnemiesKilled: "..enemiesKilled
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

local function gameOver()
  if lives == 0 then
    backToStart()
  end
end

local function backToBeginning()
  if died == true then
    deathText = display.newText( "YOU DIED" )
    enemiesKilled = 0
    composer.gotoScene("level2")
  end
end

Runtime:addEventListener("enterFrame",bgScroll
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
