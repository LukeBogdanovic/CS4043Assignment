-- menu.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToGame()
  composer.gotoScene( "story1", {time=500, effect="crossFade"} )
end

local function goToOptions()
  composer.gotoScene("options",{time=500,effect="crossFade"})
end

local backGroup
local uiGroup
local music = audio.loadSound( "music/Menu.mp3" )
local musicChannel
local ClickButton = audio.loadSound( "sounds/ClickButton.mp3" )
local CLickButtonChannel

local function volumeSet()
  audio.setVolume( 0.5 )
end

function scene:create( event )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert( backGroup )

  uiGroup = display.newGroup()
  sceneGroup:insert( uiGroup )

  volumeSet()

  local background = display.newImageRect( backGroup , "img/Level1Background.png" , 1920 , 1080 )
  background.x = display.contentCenterX
  background.y  = display.contentCenterY

  local title = display.newImageRect( backGroup, "img/title.png", 600, 300 )
  title.x = display.contentCenterX
  title.y = 200

  local playButton = display.newImageRect( uiGroup, "img/Button.png",  600, 400 )
  playButton.x = display.contentCenterX - 25
  playButton.y = 450

  local optionsButton = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
  optionsButton.x = display.contentCenterX - 25
  optionsButton.y = 750

  local playText = display.newText( uiGroup,"Play",display.contentCenterX-25,450,"Font.ttf",108 )

  local optionsText = display.newText( uiGroup,"Options",display.contentCenterX-25,750,"Font.ttf",108 )


  local function Buttonclicked (event)
    audio.setVolume( .5, { channel= ClickButtonChannel } )
    ClickButtonChannel = audio.play( ClickButton,{channel=2, loops = 0})
  end

  musicChannel = audio.play( music ,{channel = 1, loops = -1} )

  playButton:addEventListener("tap", Buttonclicked)
  playButton:addEventListener("tap", goToGame)
  optionsButton:addEventListener("tap", Buttonclicked)
  optionsButton:addEventListener("tap", goToOptions)
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
    composer.removeScene( "menu" )
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
