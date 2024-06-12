local maps = {}
local love = require("love")

-- Screen is 10x9 tiles
-- Outside area is: 10x8 tiles explorable, with 10x1 at bottom for status
function maps.init_map()
  local map = {
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 0, 0, 0, 1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 1, 0, 0, 0, 0, 1,
    1, 0, 1, 1, 1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  }
  return map
end

function maps.is_collision(x, y)
  local coord_x1 = math.floor((x) / 96) + 1
  local coord_y1 = math.floor((y) / 96) + 1
  local coord_x2 = math.floor((x + 72) / 96) + 1
  local coord_y2 = math.floor((y + 72) / 96) + 1
  if Map[(coord_y1 - 1) * 10 + (coord_x1 - 1) + 1] == 1 or
     Map[(coord_y1 - 1) * 10 + (coord_x2 - 1) + 1] == 1 or
     Map[(coord_y2 - 1) * 10 + (coord_x1 - 1) + 1] == 1 or
     Map[(coord_y2 - 1) * 10 + (coord_x2 - 1) + 1] == 1 then
    return true
  else
    return false
  end
end

function maps.draw_map()
  love.graphics.clear(0, 0.75, 0)
  love.graphics.setColor(0.5, 0.25, 0)
  for x = 1, 10 do
    for y = 1, 8 do
      local cur_tile = Map[(y - 1) * 10 + (x - 1) + 1]
      if cur_tile == 1 then
        love.graphics.rectangle("fill", (x - 1) * 96 + 6, (y - 1) * 96 + 6, 84, 84)
      end
    end
  end
  love.graphics.setColor(1, 1, 1)
end

return maps
