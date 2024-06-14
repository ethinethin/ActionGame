local player = {}
local love = require("love")
local consts = require("consts")
local maps = require("maps")
local sprites = require("sprites")

function player.init_player()
  local player = { x = 0, y = 0, up = false, left = false, down = false, right = false, frame = 1, f_count = 0, count_max1 = 60, count_max2 = 20, facing = 3 }
  local start_x = 2
  local start_y = 2
  player.x = (start_x - 1) * consts.SPRITE_W * consts.SPRITE_SCALE
  player.y = (start_y - 1) * consts.SPRITE_H * consts.SPRITE_SCALE
  return player
end

local function animate_player(dt)
  Player.f_count = Player.f_count + 300 * dt
  if Player.frame == 1 then
    if Player.f_count >= Player.count_max1 then
      Player.f_count = 0
      Player.frame = 2
    end
  elseif Player.frame == 2 then
    if Player.f_count >= Player.count_max2 then
      Player.f_count = 0
      Player.frame = 1
    end
  end
end

function player.move(dt)
  if Player.up then
    Player.y = Player.y - 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.y = Player.y + 1
    end
    Player.facing = 1
  end
  if Player.left then
    Player.x = Player.x - 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.x = Player.x + 1
    end
    Player.facing = 2
  end
  if Player.down then
    Player.y = Player.y + 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.y = Player.y - 1
    end
    Player.facing = 3
  end
  if Player.right then
    Player.x = Player.x + 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.x = Player.x - 1
    end
    Player.facing = 4
  end
  if Player.up or Player.left or Player.down or Player.right then
    animate_player(dt)
  end
end

function player.draw_player()
  local cur_sprite
  -- choose animation frame
  if Player.frame == 1 then
    cur_sprite = 3
  else
    cur_sprite = 4
  end
  -- choose direction
  if Player.facing == 2 then
    cur_sprite = cur_sprite + 2
  elseif Player.facing == 3 then
    cur_sprite = cur_sprite + 4
  elseif Player.facing == 4 then
    cur_sprite = cur_sprite + 6
  end
  sprites.draw_sprite(Player.x, Player.y, cur_sprite)
end

function player.walk(key)
  if key == "w" or key == "up" then Player.up = true end
  if key == "a" or key == "left" then Player.left = true end
  if key == "s" or key == "down" then Player.down = true end
  if key == "d" or key == "right" then Player.right = true end
end

function player.unwalk(key)
  if key == "w" or key == "up" then Player.up = false end
  if key == "a" or key == "left" then Player.left = false end
  if key == "s" or key == "down" then Player.down = false end
  if key == "d" or key == "right" then Player.right = false end
end

return player
