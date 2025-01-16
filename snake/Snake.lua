local Snake = {}
Snake.__index = Snake

function Snake.new(init_len, grid)
  local self = setmetatable({}, Snake)

  local x, y = grid:randomFreeCell()
  self.head = {x = x, y = y}
  self.trail = {}
  self.length = init_len
  self.facing = nil

  self.grid = grid

  return self
end

return Snake
