local Snake = {}
Snake.__index = Snake

function Snake.new(init_len, grid)
  local self = setmetatable({}, Snake)

  self.head = {}

  return self
end

return Snake
