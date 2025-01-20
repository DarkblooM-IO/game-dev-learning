_G.lg = love.graphics

GRID_SIZE = {w = 10, h = 20}
UI_MARGIN = 10

local socket = require "socket"
local pieces = require "pieces"

local display
local next_display
local held_display
local font

local grid

local current_piece
local next_piece
local held_piece

local level
local score
local timer

local function spawnPiece()
  local out = {}

  out.index = math.random(#pieces.tetrominos)
  out.state = 1

  local x = math.floor(#pieces.tetrominos[out.index].states[out.state] / 2) + pieces.tetrominos[out.index].offset
  out.pos = {x = x, y = 0}

  return out
end

local function updateDisplays()
  local w = #pieces.tetrominos[next_piece.index].states[next_piece.state][1] * pieces.PIXEL_SIZE
  local h = #pieces.tetrominos[next_piece.index].states[next_piece.state] * pieces.PIXEL_SIZE
  next_display = lg.newCanvas(w, h)

  if held_piece ~= nil then
    local w = #pieces.tetrominos[held_piece.index].states[held_piece.state][1] * pieces.PIXEL_SIZE
    local h = #pieces.tetrominos[held_piece.index].states[held_piece.state] * pieces.PIXEL_SIZE
    held_display = lg.newCanvas(w, h)
  end
end

function love.load()
  math.randomseed(math.floor(socket.gettime()) * 1000)

  grid = {}
  for y = 1, GRID_SIZE.h do
    local row = {}
    for x = 1, GRID_SIZE.w do table.insert(row, 0) end
    table.insert(grid, row)
  end

  display = lg.newCanvas(GRID_SIZE.w * pieces.PIXEL_SIZE, GRID_SIZE.h * pieces.PIXEL_SIZE)
  font = lg.newFont(24)
  lg.setFont(font)

  current_piece = spawnPiece()
  next_piece = spawnPiece()

  updateDisplays()

  level = 1
  score = 0
  timer = {max = 70, current = 100}
end

function love.update(dt)
  if timer.current == 0 then
    -- current_piece.pos.y = current_piece.pos.y + 1
  end
  timer.current = timer.current > 0 and timer.current - 1 or timer.max
end

function love.draw()
  lg.setCanvas(display)

  lg.setColor(.1,.1,.1)
  lg.rectangle("fill", 0, 0, display:getWidth(), display:getHeight())

  lg.setColor(1, 1, 1)
  pieces.drawPiece(pieces.tetrominos[current_piece.index], current_piece.state, current_piece.pos.x, current_piece.pos.y)

  lg.setCanvas(next_display)
  pieces.drawPiece(pieces.tetrominos[next_piece.index], next_piece.state, 0, 0)

  lg.setCanvas()

  local x = lg.getWidth() - display:getWidth()
  local y = (lg.getHeight() / 2) - (display:getHeight() / 2)
  lg.draw(display, x, y)

  x = UI_MARGIN
  y = UI_MARGIN

  lg.print(string.format("Score: %d", score), x, y)

  y = y + font:getHeight() + UI_MARGIN

  lg.print("Next:", x, y)

  y = y + (next_display:getHeight() / 2)

  lg.draw(next_display, x, y)

  y = y + next_display:getHeight() + UI_MARGIN

  lg.print("Held:", x, y)
end

function love.keypressed(key, scancode)
  if scancode == "escape" then love.event.quit() end
end
