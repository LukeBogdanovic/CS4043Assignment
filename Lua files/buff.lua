--buff.lua


local function keyPress(event)
  --if (event.keyName)
end

local options =
{
    --required parameters
    width = 207,
    height = 288,
    numFrames = 8 }


local buffsheet = graphics.newImageSheet( "img/buffsheet.png" , options )

local buffseq = {
    {
      name = "run",
      start = 1,
      count = 8,
      time = 1100,
      loopCount = 0,
      loopDirection = "forward"
   }
}

local buff = display.newSprite( buffsheet, buffseq )
buff.x = display.contentCenterX
buff.y = 900
buff:setSequence( "run" )
--buff:play()

function walkBuff( event )
  if (event.keyName == 'd' and event.phase == 'down') then
    buff.x = buff.x + 30
    buff:play()
    return true
  end
  if (event.keyName == 'a' and event.phase == 'down') then
      buff.x = buff.x - 30
      buff:play()
      return true
  end
  buff:pause()
end

function buffJump(event)
  if(event.keyName == "space" and event.phase == 'down') then
    buff:applyLinearImpulse(0,-10)
  end
end

Runtime:addEventListener("key",walkBuff)
Runtime:addEventListener("key",buffJump)

return buff
