local socket = require "socket"

PIXEL_SIZE = 15
SPEED = 0.1
GROWTH_FACTOR = 3

function drawPixel(grid, y, x)
  love.graphics.setColor(255, 255, 255, math.min(grid[y][x], 1))
  love.graphics.rectangle("fill", x, y, PIXEL_SIZE, PIXEL_SIZE)
end

function randomFreeSpot(grid)
  local freespots = {}
  for y = 1, #grid do
    for x = 1, #grid[y] do
      if grid[y][x] == 0 then table.insert(freespots, {y = y, x = x}) end
    end
  end
  local choice = freespots[math.random(#freespots)]
  return {y = choice.y, x = choice.x}
end

function love.load()
  math.randomseed(socket.gettime() * 1000)

  grid = {}
  for y = 1, love.graphics.getHeight() / PIXEL_SIZE do
    for x = 1, love.graphics.getWidth() / PIXEL_SIZE do
      table.insert(grid, 0)
    end
  end

  snake = {}
    snake.pos = randomFreeSpot(grid)
    snake.length = GROWTH_FACTOR
    snake.path = {}
    snake.facing = nil

  last_key = nil
end

function love.update(dt)
  table.insert(snake.path, 1, {y = snake.pos.y, x = snake.pos.x})

  if #snake.path > snake.length then table.remove(snake.path, #snake.path) end

  if last_key == "up" and snake.facing ~= "down" then snake.facing = "up"
  elseif last_key == "down" and snake.facing ~= "up" then snake.facing = "down"
  elseif last_key == "left" and snake.facing ~= "right" then snake.facing = "left"
  elseif last_key == "right" and snake.facing ~= "left" then snake.facing = "right" end

  if snake.facing == "up" then snake.pos.y = snake.pos.y - 1
  elseif snake.facing == "down" then snake.pos.y = snake.pos.y + 1
  elseif snake.facing == "left" then snake.pos.x = snake.pos.x - 1
  elseif snake.facing == "right" then snake.pos.x = snake.pos.x + 1 end

  socket.sleep(SPEED)
end

function love.draw()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
  if scancode == "return" then snake.length = snake.length + GROWTH_FACTOR end -- DEBUG
  last_key = scancode
end
