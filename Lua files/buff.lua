local function walkBuff(event)
  if (event.keyName == 'd' and event.phase == 'down') then
    buff.x = buff.x + 15
    return true
  end
  if (event.keyName == 'a' and event.phase == 'down') then
    buff.x = buff.x - 15
    return true
  end
end
