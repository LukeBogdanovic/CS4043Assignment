--pause.lua
local composer = require("composer")

local scene = composer.newScene()

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene 
