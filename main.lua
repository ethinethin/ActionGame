-- Load libraries etc.
local consts = require("consts")
local font = require("font")
local love = require("love")
local maps = require("maps")
local player = require("player")
local sprites = require("sprites")
local states = {
  fishing = require("states.fishing"),
  ingame_menu = require("states.ingame_menu"),
  main_menu = require("states.main_menu"),
  options = require("states.options"),
  walk = require("states.walk")
}

function love.load()
  -- Set up window and canvas
  love.window.setMode(consts.SCREEN_W, consts.SCREEN_H, {resizable = false})
  love.window.setTitle("ActionGame")
  love.window.setPosition(0, 0)
  Canvas = love.graphics.newCanvas(consts.CANVAS_W, consts.CANVAS_H)
  -- Load font
  font.load_font()
  -- State management
  State = "walk"
  -- Setup initial map
  Map = maps.init_map()
  -- Setup player
  Player = player.init_player()
  -- Load sprites
  Sprites = sprites.load_sprites()
end

function love.update(dt)
  if State == "fishing" then
    states.fishing.update(dt)
  elseif State == "ingame_menu" then
    states.ingame_menu.update(dt)
  elseif State == "main_menu" then
    states.main_menu.update(dt)
  elseif State == "options" then
    states.options.update(dt)
  elseif State == "walk" then
      states.walk.update(dt)
  end
end

function love.draw()
  love.graphics.setCanvas(Canvas)
  love.graphics.clear(0, 0, 0)
  if State == "fishing" then
    states.fishing.draw()
  elseif State == "ingame_menu" then
    states.ingame_menu.draw()
  elseif State == "main_menu" then
    states.main_menu.draw()
  elseif State == "options" then
    states.options.draw()
  elseif State == "walk" then
    states.walk.draw()
  end
  love.graphics.setCanvas()
  love.graphics.draw(Canvas, 0, 0, 0, consts.SCALE_X, consts.SCALE_Y)
end

function love.keypressed(key, scancode, isrepeat)
  if State == "fishing" then
    states.fishing.keypressed(key, scancode, isrepeat)
  elseif State == "ingame_menu" then
    states.ingame_menu.keypressed(key, scancode, isrepeat)
  elseif State == "main_menu" then
    states.main_menu.keypressed(key, scancode, isrepeat)
  elseif State == "options" then
    states.options.keypressed(key, scancode, isrepeat)
  elseif State == "walk" then
    states.walk.keypressed(key, scancode, isrepeat)
  end
end

function love.keyreleased(key, scancode)
  if State == "fishing" then
    states.fishing.keyreleased(key, scancode)
  elseif State == "ingame_menu" then
    states.ingame_menu.keyreleased(key, scancode)
  elseif State == "main_menu" then
    states.main_menu.keyreleased(key, scancode)
  elseif State == "options" then
    states.options.keyreleased(key, scancode)
  elseif State == "walk" then
    states.walk.keyreleased(key, scancode)
  end
end
