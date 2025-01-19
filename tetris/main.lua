_G.lg = love.graphics

PIXEL_SIZE = 20

require "Piece"

local display
local tetromino

function love.load()
  display = lg.newCanvas(lg.getHeight() * 1/2, lg.getHeight())
  tetromino = Piece.new({{0, 1, 0}, {1, 1, 1}}, 154, 0, 205)
end

function love.update(dt)
end

function love.draw()
  tetromino:draw(display)

  lg.setCanvas()

  local x = (lg.getWidth() / 2) - (display:getWidth() / 2)
  local y = (lg.getHeight() / 2) - (display:getHeight() / 2)
  lg.draw(display, x, y)
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
