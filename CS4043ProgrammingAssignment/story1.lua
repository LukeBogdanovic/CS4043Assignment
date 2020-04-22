--story1.lua
local composer = require( "composer" )

local scene = composer.newScene()

local function goToLevel()
  composer.gotoScene( "Level1","fade" )
end

local backGroup

function create:scene(event)
  local sceneGroup = self.view

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
    composer.removeScene( "story1", shouldRecycle )

  end
end

function scene:destroy( event )

  local sceneGroup = self.view

end
