local socket = require "socket"
local Game = require "Game"

PIXEL_SIZE = 10
SPEED = 0.05

function love.load()
  game = Game.new()
end

function love.update(dt)
  game:update()
  game.snake:update()
  socket.sleep(SPEED)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
  game.lastkey = scancode
end
