local utils = require "utils"
local socket = require "socket"

PIXEL_SIZE = 20
GROWTH_FACTOR = 3
SPEED = 0.05
BG_COLOR = {love.math.colorFromBytes(112, 181, 91)}
FRUIT_COLOR = {love.math.colorFromBytes(189, 40, 40)}
SNAKE_COLOR = {love.math.colorFromBytes(87, 86, 184)}

function drawPixel(x, y, line)
  love.graphics.rectangle(line and "line" or "fill", x * PIXEL_SIZE - PIXEL_SIZE, y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
end

function love.load()
  love.graphics.setDefaultFilter("nearest")

  grid = {}

  local w = math.floor(love.graphics.getWidth() / PIXEL_SIZE)
  local h = math.floor(love.graphics.getHeight() / PIXEL_SIZE)
  for y = 1, h do
    local row = {}
    for x = 1, w do
      table.insert(row, nil)
    end
    table.insert(grid, row)
  end

  fruit = utils.Vec2.new(math.floor(w - 5), math.floor(h / 2))

  snake = {}
    snake.length = GROWTH_FACTOR
    snake.body = {utils.Vec2.new(5 + GROWTH_FACTOR, math.floor(h / 2))}
    snake.facing = nil

  for i = 2, snake.length do
    snake.body[i] = snake.body[i - 1] - utils.Vec2.new(-1, 0)
  end
end

function love.update(dt)
  if snake.facing == "up" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(0, -1))
  elseif snake.facing == "down" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(0, 1))
  elseif snake.facing == "left" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(-1, 0))
  elseif snake.facing == "right" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(1, 0)) end

  if #snake.body > snake.length then table.remove(snake.body[#snake.body]) end

  socket.sleep(SPEED)
end

function love.draw()
  -- reset
  love.graphics.setColor(BG_COLOR)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  -- print score
  love.graphics.setColor(0, 0, 0)
  love.graphics.print("Score: "..tostring((snake.length / GROWTH_FACTOR) - 1), 5, 5, 0, 2, 2)

  -- draw fruit
  love.graphics.setColor(FRUIT_COLOR)
  drawPixel(fruit.x, fruit.y)
  love.graphics.setColor(BG_COLOR)
  drawPixel(fruit.x, fruit.y, true)

  -- draw snake
  for i = 1, snake.length do
    love.graphics.setColor(SNAKE_COLOR)
    drawPixel(snake.body[i].x, snake.body[i].y)
    love.graphics.setColor(BG_COLOR)
    drawPixel(snake.body[i].x, snake.body[i].y, true)
  end
end

function love.keypressed(key, scancode, insert)
  if scancode == "escape" then love.event.quit() end

  if scancode == "w" and snake.facing ~= "down" then snake.facing = "up"
  elseif scancode == "s" and snake.facing ~= "up" then snake.facing = "down"
  elseif scancode == "a" and snake.facing ~= "right" then snake.facing = "left"
  elseif scancode == "d" and snake.facing ~= "left" then snake.facing = "right" end
end
