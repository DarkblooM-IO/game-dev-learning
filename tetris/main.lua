_G.lg = love.graphics

GRID_SIZE = {w = 10, h = 20}

local socket = require "socket"
local pieces = require "pieces"

local display
local font

local grid = {}

local current_piece = {}
local next_piece = {}
local held_piece = {}

local level
local score
local update_timer

local function spawnPiece()
  current_piece.index = 2 -- math.random(#pieces.tetrominos)
  current_piece.state = 1
  local x = math.floor(#pieces.tetrominos[current_piece.index].states[current_piece.state] / 2)
  current_piece.pos = {x = x + pieces.tetrominos[current_piece.index].offset, y = 0}
end

function love.load()
  math.randomseed(math.floor(socket.gettime()) * 1000)

  for y = 1, GRID_SIZE.h do
    local row = {}
    for x = 1, GRID_SIZE.w do table.insert(row, 0) end
    table.insert(grid, row)
  end

  display = lg.newCanvas(GRID_SIZE.w * pieces.PIXEL_SIZE, GRID_SIZE.h * pieces.PIXEL_SIZE)
  font = lg.newFont(24)
  lg.setFont(font)

  spawnPiece()

  level = 1
  score = 0
  update_timer = 100
end

function love.update(dt)
end

function love.draw()
  lg.setCanvas(display)

  lg.setColor(.1,.1,.1)
  lg.rectangle("fill", 0, 0, display:getWidth(), display:getHeight())

  lg.setColor(.2, .2, .2)
  for y = 1, #grid do
    for x = 1, #grid[y] do pieces.drawPixel(x, y, true) end
  end

  lg.setColor(1, 1, 1)
  pieces.drawPiece(pieces.tetrominos[current_piece.index], current_piece.state, current_piece.pos.x, current_piece.pos.y)

  lg.setCanvas()

  local x = lg.getWidth() - display:getWidth()
  local y = (lg.getHeight() / 2) - (display:getHeight() / 2)
  lg.draw(display, x, y)

  x = 10
  y = 10
  lg.print(string.format("Score: %d", score), x, y)
end

function love.keypressed(key, scancode)
  if scancode == "escape" then love.event.quit() end
end
