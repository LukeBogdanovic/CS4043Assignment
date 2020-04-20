--level2.lua
local globalData = require ("globalData")

local composer = require("composer")

local scene = composer.newScene()

local physics  = require("physics")
physics.start()
physics.setGravity(0,0)

local lives = 3
local died = false
local  livesText
local backGroup
local mainGroup
local uiGroup

function scene:create(event)
  local sceneGroup = self.view

  physics.pause()

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  local background1 = display.newImageRect(backGroup,"Level2Background.png",800,1400)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local background2 = display.newImageRect( backGroup , "Level2Background.png" , 1920 , 1080 )
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  local background3 = display.newImageRect( backGroup , "Level2Background.png" , 1920 , 1080 )
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  livesText	= display.newText( uiGroup,"Lives: "..lives,200,80,native.systemFont,36 )

end

local function updateText()
  livesText.text = "Lives: "..lives
end

local function move(event)
  background1.x = background1.x + scrollSpeed
  background2.x = background2.x + scrollSpeed
  background3.x = background3.x + scrollSpeed

  if (bg1.x + bg1.contentWidth) &#62; 1040 then
 bg1:translate( 0, -960 )
end
if (bg2.x + bg2.contentWidth) &#62; 1040 then
 bg2:translate( 0, -960 )
end
if (bg3.x + bg3.contentWidth) &#62; 1040 then
 bg3:translate( 0, -960 )
end
