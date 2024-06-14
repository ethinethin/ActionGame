local sprites = {}
local consts = require("consts")
local love = require("love")

function sprites.load_sprites()
  local sprites = {
    image = love.graphics.newImage("art/sprites.png"),
    quads = {}
  }
  for i = 1, consts.N_SPRITES do
    table.insert(sprites.quads,
      love.graphics.newQuad((i - 1) * consts.SPRITE_W, 0, consts.SPRITE_W, consts.SPRITE_H, consts.IMAGE_W, consts.IMAGE_H))
  end
  return sprites
end

function sprites.draw_sprite(x, y, sprite)
  love.graphics.draw(Sprites.image, Sprites.quads[sprite], x, y, 0, consts.SPRITE_SCALE, consts.SPRITE_SCALE)
end

return sprites
