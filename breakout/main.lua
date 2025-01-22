_G.lg = love.graphics
_G.lk = love.keyboard

local socket = require "socket"
local ut = require "utils"

PADDLE_SIZE  = {w = 100, h = 10}
PADDLE_SPEED = 400
BALL_SIZE    = 10
BALL_SPEED   = 300

local player
local ball

function centerOnPlayer()
  return player.pos.x + (PADDLE_SIZE.w / 2) - (BALL_SIZE / 2), player.pos.y - PADDLE_SIZE.h * 2
end

function love.load()
  math.randomseed(math.floor(socket.gettime() * 1000))

  player = {}
    player.score = 0
    player.pos = ut.Vec2.new((lg.getWidth() / 2) - (PADDLE_SIZE.w / 2), lg.getHeight() - PADDLE_SIZE.h * 2)

  ball = {}
    ball.pos = ut.Vec2.new(centerOnPlayer())
    ball.vel = ut.Vec2.new(0,0)
end

function love.update(dt)
  if (lk.isDown("left") and player.pos.x > 0) then player.pos.x = player.pos.x - PADDLE_SPEED * dt end
  if (lk.isDown("right") and player.pos.x + PADDLE_SIZE.w < lg.getWidth()) then player.pos.x = player.pos.x + PADDLE_SPEED * dt end

  if (ball.vel == ut.Vec2.new(0,0)) then ball.pos = ut.Vec2.new(centerOnPlayer()) end
end

function love.draw()
  lg.rectangle("fill", player.pos.x, player.pos.y, PADDLE_SIZE.w, PADDLE_SIZE.h)
  lg.rectangle("fill", ball.pos.x, ball.pos.y, BALL_SIZE, BALL_SIZE)
end

function love.keypressed(key, scancode)
  if scancode == "escape" then love.event.quit() end
end
