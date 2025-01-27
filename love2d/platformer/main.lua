_G.lg = love.graphics
_G.lk = love.keyboard

local ent = require "utils.entities"
local tick = require "utils.tick"

RUN_SPEED = 10

local player

function love.load()
  tick.framerate = 60

  local x = lg.getWidth() / 2
  local y = lg.getHeight() / 2
  player = ent.PhysicsEntity.new(x,y, 15,15)
  player.movement = {0,0}
end

function love.update(dt)
  player.movement = {
    lk.isDown("left") and not lk.isDown("right") and 1 or 0,
    lk.isDown("right") and not lk.isDown("left") and 1 or 0
  }
  player.pos.x = player.pos.x + RUN_SPEED * (player.movement[2] - player.movement[1])
end

function love.draw()
  player:draw()
end

function love.keypressed(key, scancode)
  if scancode == "escape" then love.event.quit() end
end
