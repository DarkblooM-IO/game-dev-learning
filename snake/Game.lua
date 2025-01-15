local socket = require "socket"

GROWTH_FACTOR = 1

local Snake = {}
Snake.__index = Snake

function Snake.new(game)
  local self = setmetatable({}, Snake)

  self.game = game

  local x, y = game:randomFreeSpot()
  self.head = {x = x, y = y}
  self.trail = {}
  self.length = GROWTH_FACTOR

  self.facing = nil

  return self
end

function Snake:update()
  local pos = self.game.grid[self.head.y][self.head.x]

  if self.game.lastkey ~= nil then
    if pos == 1 then
      self:kill()
      return
    elseif pos == 2 then self.length = self.length + GROWTH_FACTOR end

    table.insert(self.trail, 1, self.head)
    if #self.trail > self.length then table.remove(self.trail, #self.trail) end
    for i = 1, #self.trail do
      self.game.grid[self.trail[i].y][self.trail[i].x] = 1
    end

    if self.facing == "up" then self.head.y = self.head.y - 1
    elseif self.facing == "down" then self.head.y = self.head.y + 1
    elseif self.facing == "left" then self.head.x = self.head.x - 1
    elseif self.facing == "right" then self.head.x = self.head.x + 1 end
  end
end

function Snake:kill()
  print("💀")
  self.facing = nil
  self.game.lastkey = nil
end

local Game = {}
Game.__index = Game

function Game.new(seed)
  math.randomseed(seed or socket.gettime() * 1000)

  local self = setmetatable({}, Game)

  self.lastkey = nil

  self.gridwidth = math.floor(love.graphics.getWidth() / PIXEL_SIZE)
  self.gridheight = math.floor(love.graphics.getHeight() / PIXEL_SIZE)

  self.grid = {}
  self:update()

  self.snake = Snake.new(self)

  self.fruit = {}
  self:setFruit()

  return self
end

function Game:update()
  for y = 1, self.gridheight do
    local row = {}
    for x = 1, self.gridwidth do
      table.insert(row, (y == 1 or y == self.gridheight or x == 1 or x == self.gridwidth) and 1 or 0)
    end
    table.insert(self.grid, y, row)
  end

  self.grid[self.fruit.y][self.fruit.x] = 2

  if self.lastkey == "up" and self.snake.facing ~= "down" then self.snake.facing = self.lastkey
  elseif self.lastkey == "down" and self.snake.facing ~= "up" then self.snake.facing = self.lastkey
  elseif self.lastkey == "left" and self.snake.facing ~= "right" then self.snake.facing = self.lastkey
  elseif self.lastkey == "right" and self.snake.facing ~= "left" then self.snake.facing = self.lastkey end
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

function Game:setFruit()
  local x, y = self:randomFreeSpot()
  self.fruit = {x = x, y = y}
end

function Game:draw()
  for y = 1, self.gridheight do
    for x = 1, self.gridwidth do
      love.graphics.setColor(255, 255, 255, math.min(self.grid[y][x], 1))
      love.graphics.rectangle("fill", x * PIXEL_SIZE - PIXEL_SIZE, y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
    end
  end
  love.graphics.rectangle("fill", self.snake.head.x * PIXEL_SIZE - PIXEL_SIZE, self.snake.head.y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
end

return Game
