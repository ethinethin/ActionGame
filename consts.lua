local consts = {
  SCREEN_W = 960,
  SCREEN_H = 864,
  CANVAS_W = 640,
  CANVAS_H = 576,
  SCALE_X = 0,
  SCALE_Y = 0,
  FONT_SCALE = 48/128 
}

consts.SCALE_X = consts.SCREEN_W / consts.CANVAS_W
consts.SCALE_Y = consts.SCREEN_H / consts.CANVAS_H

return consts
