local consts = {
  SCREEN_W = 960,
  SCREEN_H = 864,
  CANVAS_W = 640,
  CANVAS_H = 576,
  SCALE_X = nil,
  SCALE_Y = nil,
  FONT_SCALE = 48/128,
  N_SPRITES = 10,
  SPRITE_W = 128,
  SPRITE_H = 128,
  SPRITE_SCALE = 0.5,
  IMAGE_W = nil,
  IMAGE_H = nil
}

-- Dynamic constants
consts.SCALE_X = consts.SCREEN_W / consts.CANVAS_W
consts.SCALE_Y = consts.SCREEN_H / consts.CANVAS_H
consts.IMAGE_W = consts.N_SPRITES * consts.SPRITE_W
consts.IMAGE_H = consts.SPRITE_H

return consts
