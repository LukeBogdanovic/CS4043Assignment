-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
<<<<<<< HEAD
local composer = require("composer")

local scene = composer.newScene()

local physics  = require("physics")
physics.start()
physics.setGravity(0,0)
=======
>>>>>>> e5700212fe98e129bd2595ab5d71fa234d297a74

local lives = 3
local died = false

local  livesText

<<<<<<< HEAD
local backGroup
local mainGroup
local uiGroup
=======
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()
>>>>>>> e5700212fe98e129bd2595ab5d71fa234d297a74

--local background = display.newImageRect(backGroup,"",,)
--background.x = display.contentCenterX
--background.y = display.contentCenterY

livesText	= display.newText( uiGroup,"Lives: "..lives,200,80,native.systemFont,36 )

local function updateText()
  livesText.text = "Lives: "..lives
end
<<<<<<< HEAD

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
end
=======
>>>>>>> e5700212fe98e129bd2595ab5d71fa234d297a74
