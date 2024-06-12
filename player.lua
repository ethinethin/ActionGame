local player = {}
local love = require("love")
local maps = require("maps")

function player.init_player()
  local player = { x = 0, y = 0, up = false, left = false, down = false, right = false }
  local start_x = 2
  local start_y = 2
  player.x = (start_x - 1) * 96 + 12
  player.y = (start_y - 1) * 96 + 12
  return player
end

function player.move(dt)
  if Player.up then
    Player.y = Player.y - 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.y = Player.y + 1
    end
  end
  if Player.left then
    Player.x = Player.x - 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.x = Player.x + 1
    end
  end
  if Player.down then
    Player.y = Player.y + 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.y = Player.y - 1
    end
  end
  if Player.right then
    Player.x = Player.x + 1 * 300 * dt
    while maps.is_collision(Player.x, Player.y) do
      Player.x = Player.x - 1
    end
  end
end

function player.draw_player()
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle("fill", Player.x, Player.y, 72, 72)
  love.graphics.setColor(1, 1, 1)
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
