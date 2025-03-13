_G.lg = love.graphics

local socket = require "socket"

COL_WIDTH = lg.getWidth() * 0.01

local list
local start
local i

function love.load()
  math.randomseed(os.time())
  list = {}
  start = false
  i = 1
  for ii = 1, 100 do
    list[ii] = math.random(100)
  end
end

function love.update(dt)
  if start and i <= #list then
    for j = 1, #list-i do
      if list[j] > list[j+1] then
        list[j], list[j+1] = list[j+1], list[j]
      end
    end

    i = i+1
    socket.sleep(.02)
  end
end

function love.draw()
  lg.setColor(0,0,0)
  lg.rectangle("fill", 0,0, lg.getWidth(),lg.getHeight())

  lg.setColor(1,1,1)
  for ii = 1, #list do
    local height = lg.getHeight() * (list[ii]/100)
    local x = ii * COL_WIDTH - COL_WIDTH
    local y = lg.getHeight() - height
    lg.rectangle("fill", x,y, COL_WIDTH,height)
  end
end

function love.keypressed(key, scancode)
  if scancode == "escape" then love.event.quit() end
  if scancode == "return" then
    if not start then start = true
    else love.load() end
  end
end
