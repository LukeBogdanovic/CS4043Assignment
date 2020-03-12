-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
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

local function updateText()
  livesText.text = "Lives: "..lives
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

  local background = display.newImageRect(backGroup,"background1.png",800,1400)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  livesText	= display.newText( uiGroup,"Lives: "..lives,200,80,native.systemFont,36 )

end
