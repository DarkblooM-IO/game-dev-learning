_G.lg = love.graphics
_G.lk = love.keyboard

local ut = require "utils"
local socket = require "socket"

PADDLE_SIZE = {w = 10, h = math.floor((25 / 100) * lg.getHeight())}
PADDLE_SPEED = 450
BALL_SPEED = 400

function bounceBall(paddle)
  local hitpos = (ball.pos.y - paddle.y) / PADDLE_SIZE.h
  local angle = (hitpos - 0.5) * 2
  ball.vel.x = ball.vel.x * -1
  ball.vel.y = BALL_SPEED * angle
end

function love.load()
  math.randomseed(math.floor(socket.gettime() * 1000))

  font = lg.newFont(24)

  ball = {}
    ball.pos = ut.Vec2.new(math.floor(lg.getWidth() / 2), math.floor(lg.getHeight() / 2))
    ball.vel = ut.Vec2.new(0, 0)
    ball.contact = false

  player = {}
    player.score = 0
    player.y = math.floor(lg.getHeight() / 2) - math.floor(PADDLE_SIZE.h / 2)
    player.movement = {0, 0}

  bot = {}
    bot.y = math.floor(lg.getHeight() / 2) - math.floor(PADDLE_SIZE.h / 2)
end

function love.update(dt)
  -- ball update
  if ball.vel == ut.Vec2.new(0, 0) and lk.isDown("space") then ball.vel = ball.vel + ut.Vec2.new(-BALL_SPEED, math.random(-BALL_SPEED, BALL_SPEED)) end

  ball.pos = ball.pos + ball.vel * dt

  if not ball.contact and ball.pos.x <= PADDLE_SIZE.w and ball.pos.y >= player.y and ball.pos.y <= player.y + PADDLE_SIZE.h then
    ball.contact = true
    player.score = player.score + 1
    bounceBall(player)
  elseif not ball.contact and ball.pos.x + 10 >= lg.getWidth() - PADDLE_SIZE.w and ball.pos.y >= bot.y and ball.pos.y <= bot.y + PADDLE_SIZE.h then
    ball.contact = true
    ball.vel.x = ball.vel.x * -1
  elseif ball.pos.y <= 0 then
    ball.pos.y = 0
    ball.vel.y = ball.vel.y * -1 
  elseif ball.pos.y + 10 >= lg.getHeight() then
    ball.pos.y = lg.getHeight() - 10
    ball.vel.y = ball.vel.y * -1
  elseif ball.pos.x <= 0 or ball.pos.x + 10 >= lg.getWidth() then
    love.load()
  else
    ball.contact = false
  end

  -- player update
  player.movement = {(lk.isDown("c") and player.y > 0) and 1 or 0, (lk.isDown("v") and player.y + PADDLE_SIZE.h < lg.getHeight()) and 1 or 0}
  player.y = player.y + (player.movement[2] - player.movement[1]) * PADDLE_SPEED * dt

  -- bot update
  local newpos = (ball.pos.y + 5) - math.floor(PADDLE_SIZE.h / 2)
  if (ball.pos.y + 5) - math.floor(PADDLE_SIZE.h / 2) >= 0 and (ball.pos.y + 5) + math.floor(PADDLE_SIZE.h / 2) <= lg.getHeight() then
    bot.y = newpos
  end
end

function love.draw()
  -- reset display
  lg.setColor(0, 0, 0)
  lg.rectangle("fill", 0, 0, lg.getWidth(), lg.getHeight())

  -- print controls/score
  lg.setColor(1, 1, 1, 0.5)
  local str = ball.vel == ut.Vec2.new(0, 0) and "Press C/V to go up/down\nPress SPACE to launch the ball" or tostring(player.score)
  local x = math.floor(lg.getWidth() / 2) - math.floor(font:getWidth(str) / 2)
  local y = math.floor(lg.getHeight() / 2) - math.floor(font:getHeight() / 2)
  lg.print(str, font, x, y)

  -- draw player
  lg.setColor(1, 1, 1)
  lg.rectangle("fill", 0, player.y, PADDLE_SIZE.w, PADDLE_SIZE.h)

  -- draw bot
  lg.rectangle("fill", lg.getWidth() - PADDLE_SIZE.w, bot.y, PADDLE_SIZE.w, PADDLE_SIZE.h)

  -- draw ball
  lg.rectangle("fill", ball.pos.x, ball.pos.y, 10, 10)
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
