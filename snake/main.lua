local socket = require "socket"

TILE_SIZE = 10
GROWTH_FACTOR = 3
SPEED = 0.05

function love.load()
  math.randomseed(socket.gettime() * 1000)
end

function love.update(dt)
  socket.sleep(SPEED)
end

function love.draw()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
