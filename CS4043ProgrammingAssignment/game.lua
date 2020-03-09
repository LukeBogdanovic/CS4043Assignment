-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local lives = 3
local died = false

local  livesText

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

--local background = display.newImageRect(backGroup,"",,)
--background.x = display.contentCenterX
--background.y = display.contentCenterY

livesText	= display.newText( uiGroup,"Lives: "..lives,200,80,native.systemFont,36 )

local function updateText()
  livesText.text = "Lives: "..lives
end
