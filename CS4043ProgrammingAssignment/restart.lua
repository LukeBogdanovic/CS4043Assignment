local composer = require( "composer" )

local scene = composer.newScene()

local composer = require( "composer" )

local scene = composer.newScene()


-- create()
function scene:create( event )

    local sceneGroup = self.view


end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then


    elseif ( phase == "did" ) then

        composer.removeScene("restart")
        composer.gotoScene( "main", "fade"   )

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then


    elseif ( phase == "did" ) then

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view

end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
