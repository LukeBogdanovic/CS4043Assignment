--level1.lua
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
