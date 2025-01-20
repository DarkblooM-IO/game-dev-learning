_G.lg = love.graphics

local socket = require "socket"
local pieces = require "pieces"

local display
local current_piece
local current_state

function love.load()
  math.randomseed(math.floor(socket.gettime()) * 1000)
  display = lg.newCanvas(lg.getHeight() * 1/2, lg.getHeight())
  current_piece = pieces.tetrominos[math.random(#pieces.tetrominos)]
  current_state = math.random(#current_piece.states)
end

function love.update(dt)
end

function love.draw()
  lg.setCanvas(display)
  lg.setColor(0, 0, 0)
  lg.rectangle("fill", 0, 0, display:getWidth(), display:getHeight())
  lg.setColor(1, 1, 1)

  pieces.drawPiece(current_piece, current_state, 0, 0)

  local x = (lg.getWidth() / 2) - (display:getWidth() / 2)
  local y = (lg.getHeight() / 2) - (display:getHeight() / 2)
  lg.setCanvas()
  lg.draw(display, x, y)
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
  if scancode == "return" then
    current_piece = pieces.tetrominos[math.random(#pieces.tetrominos)]
    current_state = math.random(#current_piece.states)
  end
end
