--level1.lua
local composer = require("composer")
local buff = require("buff")

local scene = composer.newScene()

local function backToStart()
  composer.gotoScene( "restart" )
end

local function nextLevel()
  composer.gotoScene( "Story2" , "fade" )
end

local physics = require("physics")
physics.start()
physics.setGravity(0,60)
physics.setDrawMode("hybrid")

_G.lives = 3
_G.died = false
local livesText
local backGroup
local mainGroup
local uiGroup
_G.scrollSpeed = 2
local background
local background2
local pauseButton
local enemiesKilled = 0
local killed = enemiesKilled + 1

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
  floor.name = "floor"

  floor.objType = "floor"
  physics.addBody( floor,"static",  {friction = 0.3,bounce = 0},{isSensor==true} )

  physics.addBody( buff,"dynamic", {density =1000000000000,bounce=0} )

  livesText	= display.newText( uiGroup,"Lives: "..lives,160,80,"Font.ttf",108 )
end

local function updateText()
  livesText.text = "Lives: "..lives
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

Runtime:addEventListener("enterFrame",bgScroll)
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
