local Grid = {}
Grid.__index = Grid

function Grid.new(tile_size, snake)
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

  self.snake = snake

  return self
end

function Grid:randomFreeCell()
  local free_cells = {}
  for y = 1, #self.cells do
    for x = 1, #self.cells do
      if self.cells[y][x] == 0 then table.insert(free_cells, {x = x, y = y}) end
    end
  end
  local cell = free_cells[math.random(#free_cells)]
  return cell.x, cell.y
end

function Grid:spawnFruit()
  local x, y = self:randomFreeCell()
  self.cells[y][x] = 2
end

function Grid:update()
  for y = 1, self.height do
    for x = 1, self.width do
      self.cells[y][x] = (y == 1 or y == self.height or x == 1 or x == self.width) and 1 or 0
    end
  end
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
