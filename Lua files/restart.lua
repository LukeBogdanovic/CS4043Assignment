local composer = require( "composer" )
local buff = require("buff")

local scene = composer.newScene()

local gameOverText
local background
local backGroup
local continueText
local mainText
local ClickButtonChannel
local ClickButton = audio.loadSound( "sounds/ClickButton.mp3" )
local music = audio.loadSound( "sounds/GameOver.mp3" )
local musicChannel

local function backtoMenu()
  composer.gotoScene( "menu",{effect = "fade"} )
end

local function backToLevel()
  composer.gotoScene( "level1" , {effect = "fade"} )
end

function Buttonclicked (event)
  audio.setVolume( .5, { channel= ClickButtonChannel } )
  ClickButtonChannel = audio.play( ClickButton,{channel=2, loops = 0})
end

function scene:create( event )
    local sceneGroup = self.view

    backGroup = display.newGroup()
    sceneGroup:insert(backGroup)

    background = display.newRect(backGroup, display.contentCenterX, display.contentCenterY, 1920, 1080 )
    background:setFillColor(0,0,0)

    gameOverText = display.newText(backGroup, "GAME OVER",display.contentCenterX,display.contentCenterY-300,"font.ttf",280 )
    gameOverText:setFillColor(255,0,0)

    continueText = display.newText(backGroup, "CONTINUE",display.contentCenterX,display.contentCenterY,"font.ttf",160 )
    continueText:setFillColor(255,0,0)

    mainText = display.newText(backGroup,"BACK TO MENU",display.contentCenterX,display.contentCenterY+250 ,"font.ttf",160)
    mainText:setFillColor(255,0,0)

    musicChannel = audio.play(music,{channel = 1,loops = 0})

    buff.x = -9000
    buff.y = 0

    continueText:addEventListener("tap", backToLevel)
    mainText:addEventListener("tap", backtoMenu)
    continueText:addEventListener("tap",Buttonclicked)
    mainText:addEventListener("tap",Buttonclicked)
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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
