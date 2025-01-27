_G.lg = love.graphics
_G.lk = love.keyboard

local ent = require "utils.entities"
local tick = require "utils.tick"

RUN_SPEED = 500

local player

function love.load()
  tick.framerate = 30

  local x = lg.getWidth() / 2
  local y = lg.getHeight() / 2
  player = ent.PhysicsEntity.new(x,y, 15,15)
    player.movement = {0,0}
end

function love.update(dt)
  player.pos = player.pos + player.vel * dt
end

function love.draw()
  player:draw()
end

function love.keypressed(key, scancode)
  if scancode == "escape" then love.event.quit() end
end
