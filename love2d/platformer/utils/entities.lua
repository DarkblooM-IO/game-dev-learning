local ut = require "utils.misc"

local lib = {}

local PhysicsEntity   = {}
PhysicsEntity.__index = PhysicsEntity

-- w and h will later be replaced by a sprite of which the width and height will be used
function PhysicsEntity.new(x,y, w,h, dyn, vel)
  local self = setmetatable({}, PhysicsEntity)

  self.pos  = ut.Vec2.new(x,y)
  self.vel  = vel or ut.Vec2.new(0,0)
  self.size = {w = w, h = h}
  self.dyn  = dyn or true

  return self
end

function PhysicsEntity:draw()
  lg.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
end

lib.PhysicsEntity = PhysicsEntity

return lib
