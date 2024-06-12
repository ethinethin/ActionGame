local walk = {}
local love = require("love")
local maps = require("maps")
local player = require("player")

function walk.update(dt)
  player.move(dt)
end

function walk.draw()
  maps.draw_map()
  player.draw_player()
end

function walk.keypressed(key, scancode, isrepeat)
  player.walk(key)
end

function walk.keyreleased(key, scancode)
  player.unwalk(key)
end

return walk
