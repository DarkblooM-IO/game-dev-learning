local utils = {}

--[ 2D vector class (https://love2d.org/wiki/Vectors) ]--

local Vec2 = {}
Vec2.__index = Vec2

function Vec2.new(x, y)
  local v = {x = x or 0, y = y or 0}
  setmetatable(v, Vec2)
  return v
end

function Vec2.__add(a, b)
  return Vec2.new(a.x + b.x, a.y + b.y)
end

function Vec2.__sub(a, b)
  return Vec2.new(a.x - b.x, a.y - b.y)
end

function Vec2.__mul(a, b)
  if type(a) == "number" then
    return Vec2.new(b.x * a, b.y * a)
  elseif type(b) == "number" then
    return Vec2.new(a.x * b, a.y * b)
  else
    error("Can only multiply vector by scalar.")
  end
end

function Vec2.__div(a, b)
  if type(b) == "number" then
    return Vec2.new(a.x / b, a.y / b)
  else
    error("Invalid argument types for vector division.")
  end
end

function Vec2.__eq(a, b)
  return a.x == b.x and a.y == b.y
end

function Vec2.__ne(a, b)
  return not Vec2.__eq(a, b)
end

function Vec2.__unm(a)
  return Vec2.new(-a.x, -a.y)
end

function Vec2.__lt(a, b)
  return a.x < b.x and a.y < b.y
end

function Vec2.__le(a, b)
  return a.x <= b.x and a.y <= b.y
end

function Vec2.__tostring(v)
  return "(" .. v.x .. ", " .. v.y .. ")"
end

utils.Vec2 = Vec2

return utils
