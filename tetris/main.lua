_G.lg = love.graphics

PIXEL_SIZE = 20

require "Piece"
local socket = require "socket"

local display
local current_piece

function love.load()
  math.randomseed(math.floor(socket.gettime()) * 1000)
  display = lg.newCanvas(lg.getHeight() * 1/2, lg.getHeight())
  current_piece = TETROMINOS[math.random(#TETROMINOS)]
end

function love.update(dt)
end

function love.draw()
  current_piece:draw(display)

  lg.setCanvas()

  local x = (lg.getWidth() / 2) - (display:getWidth() / 2)
  local y = (lg.getHeight() / 2) - (display:getHeight() / 2)
  lg.draw(display, x, y)
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
