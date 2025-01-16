local Button = {}
Button.__index = Button

function Button.new(x, y, txt, padding)
  local self = setmetatable({}, Button)
  return self
end

function love.load()
end

function love.update(dt)
end

function love.draw()
end
