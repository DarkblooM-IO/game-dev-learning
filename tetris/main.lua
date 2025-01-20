_G.lg = love.graphics

local socket = require "socket"

local display

function love.load()
  math.randomseed(math.floor(socket.gettime()) * 1000)
  display = lg.newCanvas(lg.getHeight() * 1/2, lg.getHeight())
end

function love.update(dt)
end

function love.draw()
  lg.setCanvas(display)

  -- draw game state

  local x = (lg.getWidth() / 2) - (display:getWidth() / 2)
  local y = (lg.getHeight() / 2) - (display:getHeight() / 2)
  lg.setCanvas()
  lg.draw(display, x, y)
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
