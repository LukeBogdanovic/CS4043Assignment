local dPressed = false
local aPressed = false
local spacePressed = false
local fPressed = false

local options =
{
    frames =
    {
        {   -- frame 1 main
            x = 0,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 2
            x = 216,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 3
            x = 429,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 4
            x = 642,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 5
            x = 855,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 6
            x = 1068,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 7
            x = 1281,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 8 movement end
            x = 1494,
            y = 0,
            width = 207,
            height = 294
        },
        {   -- frame 9 p1
            x = 1707,
            y = 0,
            width = 294,
            height = 294
        },
        {   -- frame 10 p2
            x = 2001,
            y = 0,
            width = 294,
            height = 294
        },
        {   -- frame 11 hurt
            x = 2295,
            y = 0,
            width = 294,
            height = 294
        },
        {   -- frame 12 minigun
            x = 2589,
            y = 0,
            width = 294,
            height = 294
        },
        {   -- frame 13 hurley 1
            x = 2883,
            y = 0,
            width = 261,
            height = 294
        },
        {   -- frame 14
            x = 3150,
            y = 0,
            width = 261,
            height = 294
        },
        {   -- frame 15
            x = 3417,
            y = 0,
            width = 261,
            height = 294
        },
        {   -- frame 16
            x = 3684,
            y = 0,
            width = 261,
            height = 294
        },
        {   -- frame 17
            x = 3951,
            y = 0,
            width = 261,
            height = 294
        },
        {   -- frame 18
            x = 4218,
            y = 0,
            width = 261,
            height = 294
        },
        {   -- frame 19
            x = 4485,
            y = 0,
            width = 261,
            height = 294
        },
        {   -- frame 20
            x = 4752,
            y = 0,
            width = 261,
            height = 294
        },
    }
}

local buffsheet = graphics.newImageSheet( "img/experiment.png" , options )

local buffseq = {
    {
      name = "walk",
      start = 1,
      count = 8,
      time = 1100,
      loopCount = 0,
      loopDirection = "forward"
   },
   {
        name = "punch",
        frames = { 1,9,10 },
        time = 300,
        loopCount = 1,
        loopDirection = "bounce"
    },
dd
}

local buff = display.newSprite( buffsheet, buffseq )
buff.x = display.contentCenterX
buff.y = 900
buff:setSequence( "punch" )
buff:setSequence("walk")
buff.isJumping = false
local physics = require("physics")
physics.start()
physics.addBody( buff, "dynamic",{bounce = 0,} )

local function key(event)
  if (event.phase == "down") then
          if (event.keyName == "f") then
              fPressed = true
          elseif (event.keyName == "space") then
              spacePressed = true
          elseif (event.keyName == "a") then
              aPressed = true
          elseif (event.keyName == "d") then
              dPressed = true
          end
      elseif (event.phase == "up") then
          if (event.keyName == "f") then
              fPressed = false
          elseif (event.keyName == "space") then
              spacePressed = false
          elseif (event.keyName == "a") then
              aPressed = false
          elseif (event.keyName == "d") then
              dPressed = false
          end
      end
end

function walkBuff( event )
    if (aPressed) then
        buff:pause("punch")
        buff.x = buff.x - 5
        buff:play("walk")
    end
    if (dPressed) then
        buff.x = buff.x + 5
        buff:play("walk")
    end
end

function buffJump(event)
  if(event.keyName == "space" and event.phase == 'down'and not buff.isJumping) then
    buff:applyLinearImpulse(0,-15*buff.mass)
    buff.isJumping = true
  end
end

function buffPunch(event)
  buff:pause("walk")
  if(fPressed)then
    buff:setSequence("punch")
    buff:play("punch")
  end
end

Runtime:addEventListener("enterFrame",walkBuff)
Runtime:addEventListener("key",buffJump)
Runtime:addEventListener("key",key)
Runtime:addEventListener("key",buffPunch)

return buff
