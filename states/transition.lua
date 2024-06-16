local transition = {}
local love = require("love")
local sprites = require("sprites")

local active_transition = { origin = -1, dest = -1, dir = -1, x = -1, y = -1 , dx = 0, dy = 0 }

function transition.update(dt)
  active_transition.x = active_transition.x + active_transition.dx * 500 * dt
  active_transition.y = active_transition.y + active_transition.dy * 500 * dt
  Player.x = Player.x + active_transition.dx * 450 * dt
  Player.y = Player.y + active_transition.dy * 430 * dt
  if active_transition.x <= -640 or active_transition.x >= 640 or
     active_transition.y <= -512 or active_transition.y >= 512 then
    Player.map = active_transition.dest
    State = "walk"
  end
end

local function draw_player()
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

function transition.draw()
  if active_transition.dir == "up" then
    love.graphics.draw(Maps.canvases[active_transition.dest], 0, active_transition.y - 511, 0, 1, 1)
    love.graphics.draw(Maps.canvases[active_transition.origin], 0, active_transition.y, 0, 1, 1)
  elseif active_transition.dir == "left" then
    love.graphics.draw(Maps.canvases[active_transition.origin], active_transition.x, 0, 0, 1, 1)
    love.graphics.draw(Maps.canvases[active_transition.dest], active_transition.x - 639, 0, 0, 1, 1)
  elseif active_transition.dir == "down" then
    love.graphics.draw(Maps.canvases[active_transition.origin], 0, active_transition.y, 0, 1, 1)
    love.graphics.draw(Maps.canvases[active_transition.dest], 0, active_transition.y + 511, 0, 1, 1)
  elseif active_transition.dir == "right" then
    love.graphics.draw(Maps.canvases[active_transition.origin], active_transition.x, 0, 0, 1, 1)
    love.graphics.draw(Maps.canvases[active_transition.dest], active_transition.x + 639, 0, 0, 1, 1)
  end
  draw_player()
end

function transition.keypressed(key, scancode, isrepeat)
end

function transition.keyreleased(key, scancode)
end

function transition.set_transition(origin, dest, dir)
  active_transition.origin = origin
  active_transition.dest = dest
  active_transition.dir = dir
  active_transition.x = 0
  active_transition.y = 0
  if dir == "up" then
    active_transition.dx = 0
    active_transition.dy = 1
  elseif dir == "left" then
    active_transition.dx = 1
    active_transition.dy = 0
  elseif dir == "down" then
    active_transition.dx = 0
    active_transition.dy = -1
  elseif dir == "right" then
    active_transition.dx = -1
    active_transition.dy = 0
  end
end

return transition
