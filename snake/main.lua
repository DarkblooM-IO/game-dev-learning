local socket = require "socket"
local Grid = require "Grid"

TILE_SIZE = 10
GROWTH_FACTOR = 3
SPEED = 0.05

function love.load()
  math.randomseed(socket.gettime() * 1000)

  grid = Grid.new(TILE_SIZE)
end

function love.update(dt)
  grid:update()
end

function love.draw()
  grid:draw()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
