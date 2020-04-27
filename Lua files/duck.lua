local ai = require("AI")

local _M = {}

local duckOptions =
{
    width = 320,
    height = 320,
    numFrames = 4
}

local duckSheet = graphics.newImageSheet( "img/ducksheetlarge.png",  duckOptions )

local duckseq = {
  {
    start = 1,
    name = "duckwalk",
    count = 3,
    time = 413,
    loopCount = 0,
    loopDirection = "forward"
  },
  {
    name = "duckMelee",
    frames = {1,4},
    time = 413,
    loopCount = 1,
    loopDirection = "bounce"
  }
}

local sprite = {duckSheet,duckseq}

function _M.newDuckAI(params)
  local img = params.img
  local group = params.group
  local x = params.x
  local y = params.y
  local aiType = params.ai_type or "patrol"
  local sprite = params.sprite or {}

  local duckObj = AI.newAI(group,img,x,y,aiType,sprite)

  return duckObj
end

return _M
