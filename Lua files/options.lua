--options.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function backToMain()
  composer.gotoScene( "menu",{time=800,effect="crossFade"} )
end

local backGroup
local uiGroup
local volumeUpButton
local volumeDownButton
local background
local backButton
local backButtonText
local title
local volume = 0.5
local volumeActual = volume*100
local volumeUpButtonText
local volumeDownButtonText
local muteButton
local volumeDisplay
local ClickButton = audio.loadSound( "sounds/ClickButton.mp3" )
local ClickButtonChannel

local function updateVolumeText(event)
  volumeText.text = "Volume: "..volume*100
end

local function volumeSet(event)
  audio.setVolume( volume )
end

local function Buttonclicked (event)
  audio.setVolume( .5, { channel= ClickButtonChannel } )
  ClickButtonChannel = audio.play( ClickButton,{channel=2, loops = 0})
end

local function volumeUp(event)
  volume =  volume  + 0.1
  if volume >= 1.0 then
    volume = 1.0
  end
end

local function volumeDown(event)
  volume = volume - 0.1
  if volume <= 0 then
    volume = 0
  end
  if(volume < 0.03)then
    volume = 0.0
  end
end

local function muteVolume(event)
  volume = 0.0
end

function scene:create( event )
  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  background = display.newImageRect( backGroup, "img/Level1Background.png",1920,1080  )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  title = display.newImageRect( backGroup, "img/title.png", 600, 300 )
  title.x = 350
  title.y = 200

  backButton = display.newImageRect( uiGroup ,"img/Button.png", 600, 400 )
  backButton.x = display.contentCenterX-25
  backButton.y = 900

  volumeUpButton = display.newImageRect( uiGroup ,"img/Button.png", 600, 400 )
  volumeUpButton.x = display.contentCenterX-25
  volumeUpButton.y = 400

  volumeDownButton = display.newImageRect( uiGroup ,"img/Button.png", 600, 400 )
  volumeDownButton.x = display.contentCenterX-25
  volumeDownButton.y = 650

  muteButton = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
  muteButton.x = display.contentCenterX-25
  muteButton.y = 150

  volumeDisplay = display.newImageRect( uiGroup, "img/Button.png", 600, 400 )
  volumeDisplay.x = 300
  volumeDisplay.y = display.contentCenterY

  backButtonText = display.newText( uiGroup ,"Back To Menu",display.contentCenterX-25,900,"Font.ttf",108 )
  volumeUpButtonText = display.newText( uiGroup,"volume Up",display.contentCenterX-25,400,"Font.ttf",108 )
  volumeDownButtonText = display.newText(uiGroup,"volume Down", display.contentCenterX-25,650,"Font.ttf",108)
  muteButtonText = display.newText(uiGroup,"Mute Volume",display.contentCenterX-25,150,"Font.ttf",108)
  volumeText = display.newText(uiGroup,"Volume: "..volume*100,300,display.contentCenterY,"Font.ttf",108)

  backButton:addEventListener("tap", backToMain)
  volumeUpButton:addEventListener("tap",volumeUp)
  volumeDownButton:addEventListener("tap",volumeDown)
  muteButton:addEventListener("tap",muteVolume)
  volumeUpButton:addEventListener("tap",volumeSet)
  volumeDownButton:addEventListener("tap",volumeSet)
  muteButton:addEventListener("tap",volumeSet)
  volumeUpButton:addEventListener("tap",updateVolumeText)
  volumeDownButton:addEventListener("tap",updateVolumeText)
  muteButton:addEventListener("tap",updateVolumeText)
  muteButton:addEventListener("tap", Buttonclicked)
  volumeDownButton:addEventListener("tap", Buttonclicked)
  backButton:addEventListener("tap", Buttonclicked)
  volumeUpButton:addEventListener("tap", Buttonclicked)
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
