--collision.lua
local buff = require("buff")
physics.addBody( buff, {density = 1.0,friction = 0.5, bounce = 0})

function onLocalCollision(self,event)
  if(event.phase == "began" ) then

  elseif ( event.phase == "ended" ) then
    physics.removeBody(  )
  end
end

buff.collision = onLocalCollision
buff:addEventListener("collision")
