local maps = {}
local love = require("love")
local consts = require("consts")
local sprites = require("sprites")

local function draw_map_canvas(map)
  -- draw grass
  for x = 1, 10 do
    for y = 1, 8 do
      sprites.draw_sprite((x - 1) * consts.SPRITE_W * consts.SPRITE_SCALE,
                          (y - 1) * consts.SPRITE_H * consts.SPRITE_SCALE, 1)
    end
  end
  -- draw blocks
  for x = 1, 10 do
    for y = 1, 8 do
      if map[(y - 1) * 10 + (x - 1) + 1] == 1 then
        sprites.draw_sprite((x - 1) * consts.SPRITE_W * consts.SPRITE_SCALE,
                            (y - 1) * consts.SPRITE_H * consts.SPRITE_SCALE, 2)
      end
    end
  end
  love.graphics.setColor(1, 1, 1)
end

-- Screen is 10x9 tiles
-- Outside area is: 10x8 tiles explorable, with 10x1 at bottom for status
function maps.init_map()
  local maps = {
    maps = {},
    canvases = {}
  }
  table.insert(maps.maps, 
  {
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 0, 0, 0, 1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 1, 0, 0, 0, 0, 1,
    1, 0, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  })
  table.insert(maps.maps, 
  {
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 1, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 1, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 1, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 1, 0, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 0, 0, 1, 1, 1, 1
  })
  table.insert(maps.maps, 
  {
    1, 1, 1, 1, 0, 0, 1, 1, 1, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  })
  -- Draw to canvases
  --for i = 1, #maps.maps do
  for i = 1, #maps.maps do
    local new_canvas = love.graphics.newCanvas(consts.CANVAS_W, consts.CANVAS_H)
    love.graphics.setCanvas(new_canvas)
    love.graphics.clear(0, 0, 0)
    draw_map_canvas(maps.maps[i])
    love.graphics.setCanvas()
    table.insert(maps.canvases, new_canvas)
  end
  return maps
end

function maps.is_transition(x, y, dir)
  local coord_x1 = math.floor((x + 2) / (consts.SPRITE_W * consts.SPRITE_SCALE)) + 1
  local coord_y1 = math.floor((y + 2) / (consts.SPRITE_H * consts.SPRITE_SCALE)) + 1
  local coord_x2 = math.floor((x + consts.SPRITE_W * consts.SPRITE_SCALE - 2) / (consts.SPRITE_W * consts.SPRITE_SCALE)) + 1
  local coord_y2 = math.floor((y + consts.SPRITE_H * consts.SPRITE_SCALE - 2) / (consts.SPRITE_H * consts.SPRITE_SCALE)) + 1
  if dir == "up" and coord_y1 == 0 then
    return true
  elseif dir == "left" and coord_x1 == 0 then
    return true
  elseif dir == "down" and coord_y2 == 9 then
    return true
  elseif dir == "right" and coord_x2 == 11 then
    return true
  else
    return false
  end
end

function maps.is_collision(x, y)
  local map = Maps.maps[Player.map]
  local coord_x1 = math.floor((x + 2) / (consts.SPRITE_W * consts.SPRITE_SCALE)) + 1
  local coord_y1 = math.floor((y + 2) / (consts.SPRITE_H * consts.SPRITE_SCALE)) + 1
  local coord_x2 = math.floor((x + consts.SPRITE_W * consts.SPRITE_SCALE - 2) / (consts.SPRITE_W * consts.SPRITE_SCALE)) + 1
  local coord_y2 = math.floor((y + consts.SPRITE_H * consts.SPRITE_SCALE - 2) / (consts.SPRITE_H * consts.SPRITE_SCALE)) + 1
  if coord_x1 == 0 or coord_y1 == 0 then return false end
  if map[(coord_y1 - 1) * 10 + (coord_x1 - 1) + 1] == 1 or
     map[(coord_y1 - 1) * 10 + (coord_x2 - 1) + 1] == 1 or
     map[(coord_y2 - 1) * 10 + (coord_x1 - 1) + 1] == 1 or
     map[(coord_y2 - 1) * 10 + (coord_x2 - 1) + 1] == 1 then
    return true
  else
    return false
  end
end

function maps.draw_map()
  love.graphics.draw(Maps.canvases[Player.map], 0, 0, 0, 1, 1)
end

return maps
