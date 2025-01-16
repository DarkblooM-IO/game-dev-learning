local utils = require "utils"
local socket = require "socket"

PIXEL_SIZE = 20
GROWTH_FACTOR = 3
SPEED = 0.08
BG_COLOR = {love.math.colorFromBytes(112, 181, 91)}
FRUIT_COLOR = {love.math.colorFromBytes(189, 40, 40)}
SNAKE_COLOR = {love.math.colorFromBytes(87, 86, 184)}

function getWidth()
  return math.floor(love.graphics.getWidth() / PIXEL_SIZE)
end

function getHeight()
  return math.floor(love.graphics.getHeight() / PIXEL_SIZE)
end

function drawPixel(x, y, line)
  love.graphics.rectangle(line and "line" or "fill", x * PIXEL_SIZE - PIXEL_SIZE, y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
end

function love.load()
  math.randomseed(math.floor(socket.gettime()) * 1000)
  love.graphics.setDefaultFilter("nearest")

  last_key = nil

  fruit = utils.Vec2.new(math.floor(getWidth() - 5), math.floor(getHeight() / 2))

  snake = {}
    snake.length = GROWTH_FACTOR
    snake.body = {utils.Vec2.new(5 + GROWTH_FACTOR, math.floor(getHeight() / 2))}
    snake.facing = nil

  for i = 2, snake.length do
    snake.body[i] = snake.body[i - 1] - utils.Vec2.new(1, 0)
  end
end

function love.update(dt)
  if last_key == "up" and snake.facing ~= "down" then snake.facing = "up" end
  if last_key == "down" and snake.facing ~= "up" then snake.facing = "down" end
  if last_key == "left" and snake.facing ~= "right" then snake.facing = "left" end
  if last_key == "right" and snake.facing ~= "left" then snake.facing = "right" end

  if snake.facing == "up" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(0, -1))
  elseif snake.facing == "down" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(0, 1))
  elseif snake.facing == "left" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(-1, 0))
  elseif snake.facing == "right" then table.insert(snake.body, 1, snake.body[1] + utils.Vec2.new(1, 0)) end

  if #snake.body > snake.length then table.remove(snake.body, #snake.body) end

  for i = 2, #snake.body do
    if snake.body[1] == snake.body[i] or snake.body[1].x <= 0 or snake.body[1].x > getWidth() or snake.body[1].y <= 0 or snake.body[1].y > getHeight() then
      love.load()
      break
    end
  end

  if snake.body[1] == fruit then
    snake.length = snake.length + GROWTH_FACTOR

    local free_cells = {}
    for y = 1, getHeight() do
      for x = 1, getWidth() do
        local cell = utils.Vec2.new(x, y)
        local isfree = true
        for i = 1, #snake.body do
          if snake.body[i] == cell then
            isfree = false
            break
          end
        end
        if isfree then table.insert(free_cells, cell) end
      end
    end
    fruit = free_cells[math.random(#free_cells)]
  end

  socket.sleep(SPEED)
end

function love.draw()
  -- reset display
  love.graphics.setColor(BG_COLOR)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  -- draw fruit
  love.graphics.setColor(FRUIT_COLOR)
  drawPixel(fruit.x, fruit.y)
  love.graphics.setColor(BG_COLOR)
  drawPixel(fruit.x, fruit.y, true)

  -- draw snake
  for i = 1, #snake.body do
    love.graphics.setColor(SNAKE_COLOR)
    drawPixel(snake.body[i].x, snake.body[i].y)
    love.graphics.setColor(BG_COLOR)
    drawPixel(snake.body[i].x, snake.body[i].y, true)
  end

  -- print score
  love.graphics.setColor(0, 0, 0)
  love.graphics.print("Score: "..tostring((snake.length / GROWTH_FACTOR) - 1), 5, 5, 0, 2, 2)
end

function love.keypressed(key, scancode, insert)
  if scancode == "escape" then love.event.quit() end
  last_key = scancode
end
