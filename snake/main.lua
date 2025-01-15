local socket = require "socket"

PIXEL_SIZE = 10
GROWTH_FACTOR = 3
SPEED = 0.05

local Game = {}
Game.__index = Game

function Game.new(seed)
  math.randomseed(seed or socket.gettime() * 1000)

  local self = setmetatable({}, Game)

  self.gridwidth = math.floor(love.graphics.getWidth() / PIXEL_SIZE)
  self.gridheight = math.floor(love.graphics.getHeight() / PIXEL_SIZE)

  self.grid = {}
  for y = 1, self.gridheight do
    local row = {}
    for x = 1, self.gridwidth do
      table.insert(row, (y == 1 or y == self.gridheight or x == 1 or x == self.gridwidth) and 1 or 0)
    end
    table.insert(self.grid, row)
  end

  self:spawnFruit()

  return self
end

function Game:randomFreeSpot()
  local freespots = {}
  for y = 1, self.gridheight do
    for x = 1, self.gridwidth do
      if self.grid[y][x] == 0 then table.insert(freespots, {x = x, y = y}) end
    end
  end
  local randomspot = freespots[math.random(#freespots)]
  return randomspot.x, randomspot.y
end

function Game:spawnFruit()
  local x, y = self:randomFreeSpot()
  self.grid[y][x] = 2
end

function Game:draw()
  for y = 1, self.gridheight do
    for x = 1, self.gridwidth do
      love.graphics.setColor(255, 255, 255, math.min(self.grid[y][x], 1))
      love.graphics.rectangle("fill", x * PIXEL_SIZE - PIXEL_SIZE, y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
    end
  end
end

function love.load()
  game = Game.new()
end

function love.update(dt)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
