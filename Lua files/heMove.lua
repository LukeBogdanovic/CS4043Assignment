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

math.randomseed( os.time() )

local lives = 3
local died = false

local  livesText

local backGroup
local mainGroup
local uiGroup
local cx     = display.contentCenterX
local cy     = display.contentCenterY
local fullw  = display.actualContentWidth
local fullh  = display.actualContentHeight
local left   = cx - fullw/2
local right  = cx + fullw/2
local top    = cy - fullh/2
local bottom = cy + fullh/2


local floor



floor = display.newImageRect( "floor.png",1920 ,100 )
floor.y = 1080
floor.x = display.contentCenterX

local options =
{
    --required parameters
    width = 69,
    height = 96,
    numFrames = 8 }


local buffsheet = graphics.newImageSheet( "buffsheet.png" , options )

local buffseq = {
    -- consecutive frames sequence
    {
        name = "run",
        start = 1,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    }
}

local buff = display.newSprite( buffsheet, buffseq )
buff.x = cx
buff.y = 1000
buff:setSequence( "run" )
buff:play()
