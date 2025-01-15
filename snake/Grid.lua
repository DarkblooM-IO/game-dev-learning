local Grid = {}
Grid.__index = Grid

function Grid.new(tile_size)
  local self = setmetatable({}, Grid)

  self.tile_size = tile_size
  self.width = math.floor(love.graphics.getWidth() / tile_size)
  self.height = math.floor(love.graphics.getHeight() / tile_size)
  self.cells = {}
  
  for y = 1, self.height do
    local row = {}
    for x = 1, self.width do
      table.insert(row, 0)
    end
    table.insert(self.cells, row)
  end

  return self
end

function Grid:update(snake, fruit)
  for y = 1, self.height do
    for x = 1, self.width do
      self.cells[y][x] = (y == 1 or y == self.height or x == 1 or x == self.width) and 1 or 0
    end
  end
  
  for i = 1, #snake.trail do
    self.cells[snake.trail[i].y][snake.trail[i].x] = 1
  end

  self.cells[fruit.y][fruit.x] = 2
end

function Grid:draw()
  for y = 1, self.height do
    for x = 1, self.width do
      local r = 255
      local g = 255
      local b = 255

      if self.cells[y][x] == 2 then
        g = 0
        b = 0
      end

      love.graphics.setColor(r, g, b, math.min(self.cells[y][x], 1))
      love.graphics.rectangle("fill", x * self.tile_size - self.tile_size, y * self.tile_size - self.tile_size, self.tile_size, self.tile_size)
    end
  end
end

return Grid
