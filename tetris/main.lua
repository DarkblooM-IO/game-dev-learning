_G.lg = love.graphics

local socket = require "socket"
local pieces = require "pieces"

local display
local grid = {}
local current_piece = {}
local next_piece = {}

function love.load()
  math.randomseed(math.floor(socket.gettime()) * 1000)

  display = lg.newCanvas(lg.getHeight() * 1/2, lg.getHeight())

  for y = 1, display:getHeight() / pieces.PIXEL_SIZE do
    local row = {}
    for x = 1, display:getWidth() / pieces.PIXEL_SIZE do
      table.insert(row, 0)
    end
    table.insert(grid, row)
  end

  current_piece.index = 1
  current_piece.state = 1
  current_piece.pos = {x = 0, y = 0}
end

function love.update(dt)
end

function love.draw()
  lg.setCanvas(display)

  lg.setColor(.1,.1,.1)
  lg.rectangle("fill", 0, 0, display:getWidth(), display:getHeight())

  lg.setColor(1, 1, 1)
  pieces.drawPiece(pieces.tetrominos[current_piece.index], current_piece.state, 0, 0)

  local x = (lg.getWidth() / 2) - (display:getWidth() / 2)
  local y = (lg.getHeight() / 2) - (display:getHeight() / 2)
  lg.setCanvas()
  lg.draw(display, x, y)
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
  if scancode == "return" then
    if current_piece.state < #pieces.tetrominos[current_piece.index].states then current_piece.state = current_piece.state + 1
    else
      current_piece.state = 1
      current_piece.index = current_piece.index < #pieces.tetrominos and current_piece.index + 1 or 1
    end
  end
end
