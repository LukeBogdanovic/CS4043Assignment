local ai = require("AI")

local _M = {}

local ninjaOptions =
{
    width = 294,
    height = 294,
    numFrames = 4
}

local ninjaSheet = graphics.newImageSheet( "img/ninjaSheet.png",  ninjaOptions )

local ninjaseq = {
  {
    name = "ninjawalk",
    start = 1,
    count = 3,
    time = 413,
    loopCount = 0,
    loopDirection = "forward"
  },
  {
    name = "ninjaMelee",
    frames = {1,4},
    time = 413,
    loopCount = 1,
    loopDirection = "bounce"
  }
}

local sprite = {ninjaSheet,ninjaseq}

function _M.newNinjaAI(params)
  local img = params.img
  local group = params.group
  local x = params.x
  local y = params.y
  local aiType = params.ai_type or "patrol"
  local sprite = params.sprite or {}

  local ninjaObj = AI.newAI(group,img,x,y,aiType,sprite)
  ninjaObj.type = "enemy"

  return ninjaObj
end

return _M
