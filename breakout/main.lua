local ut = require "utils"

_G.lg   = love.graphics
_G.lk   = love.keyboard
_G.Vec2 = ut.Vec2

PADDLE_SIZE  = {w = 100, h = 10}
PADDLE_SPEED = 500
BALL_SIZE    = 10
BALL_SPEED   = PADDLE_SPEED * 0.7 -- 70% of paddle speed

local player
local ball

local function overlap(a,b)
  return not (a.x > b.x + b.w 
           or a.y > b.y + b.h 
           or a.x + a.w < b.x 
           or a.y + a.h < b.y)
end

local function centerOnPlayer()
  return player.pos.x + (PADDLE_SIZE.w / 2) - (BALL_SIZE / 2), player.pos.y - PADDLE_SIZE.h * 2
end

function love.load()
  player = {}
    player.score = 0
    player.pos = Vec2.new((lg.getWidth() / 2) - (PADDLE_SIZE.w / 2), lg.getHeight() - PADDLE_SIZE.h * 2)

  ball = {}
    ball.pos = Vec2.new(centerOnPlayer())
    ball.vel = Vec2.new()
    ball.inPlayerRange = function () return ball.pos.x >= player.pos.x and ball.pos.x + BALL_SIZE <= player.pos.x + PADDLE_SIZE.w and ball.pos.y + BALL_SIZE >= player.pos.y end
    ball.shouldBounceH = function () return ball.pos.x <= 0 or ball.pos.x + BALL_SIZE >= lg.getWidth() end
    ball.shouldBounceV = function () return ball.pos.y <= 0 or ball.inPlayerRange() end
end

function love.update(dt)
  if (lk.isDown("left")  and player.pos.x > 0) then player.pos.x = player.pos.x - PADDLE_SPEED * dt end
  if (lk.isDown("right") and player.pos.x + PADDLE_SIZE.w < lg.getWidth()) then player.pos.x = player.pos.x + PADDLE_SPEED * dt end

  if (ball.vel == Vec2.new()) then
    if (lk.isDown("space")) then ball.vel = Vec2.new(100, -BALL_SPEED)
    else ball.pos = Vec2.new(centerOnPlayer()) end
  end

  ball.pos = ball.pos + ball.vel * dt

  if (ball.shouldBounceH()) then ball.vel.x = -ball.vel.x end
  if (ball.shouldBounceV()) then ball.vel.y = -ball.vel.y end
end

function love.draw()
  lg.rectangle("fill", player.pos.x, player.pos.y, PADDLE_SIZE.w, PADDLE_SIZE.h)
  lg.rectangle("fill", ball.pos.x, ball.pos.y, BALL_SIZE, BALL_SIZE)
end

function love.keypressed(key, scancode)
  if scancode == "escape" then love.event.quit() end
end
