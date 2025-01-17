--[[
TODO:
- bounce ball on paddle
--]]

local ut = require "utils"
local lg = love.graphics
local lk = love.keyboard

PADDLE_SIZE = {w = 10, h = math.floor((25 / 100) * lg.getHeight())}
PADDLE_SPEED = 450
BALL_SPEED = 300

function love.load()
  ball = {}
    ball.pos = ut.Vec2.new(math.floor(lg.getWidth() / 2), math.floor(lg.getHeight() / 2))
    ball.vel = ut.Vec2.new(0, 0)

  player = {}
    player.score = 0
    player.y = math.floor(lg.getHeight() / 2) - math.floor(PADDLE_SIZE.h / 2)
    player.movement = {0, 0}

  bot = {}
    bot.y = math.floor(lg.getHeight() / 2) - math.floor(PADDLE_SIZE.h / 2)
end

function love.update(dt)
  -- ball update
  if ball.vel == ut.Vec2.new(0, 0) and lk.isDown("space") then ball.vel = ball.vel + ut.Vec2.new(-BALL_SPEED, BALL_SPEED) end

  ball.pos = ball.pos + ball.vel * dt

  if ball.pos.x <= PADDLE_SIZE.w and ball.pos.y >= player.y and ball.pos.y <= player.y + PADDLE_SIZE.h then
    player.score = player.score + 1
    ball.vel.x = ball.vel.x * -1
  elseif ball.pos.x + 10 >= lg.getWidth() - PADDLE_SIZE.w and ball.pos.y >= bot.y and ball.pos.y <= bot.y + PADDLE_SIZE.h then
    ball.vel.x = ball.vel.x * -1
  elseif ball.pos.y <= 0 then
    ball.pos.y = 0
    ball.vel.y = ball.vel.y * -1 
  elseif ball.pos.y + 10 >= lg.getHeight() then
    ball.pos.y = lg.getHeight() - 10
    ball.vel.y = ball.vel.y * -1
  elseif ball.pos.x <= 0 or ball.pos.x + 10 >= lg.getWidth() then
    love.load()
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

  -- print score
  lg.setColor(1, 1, 1, 0.5)
  local score = "Score: "..tostring(player.score)
  local font = lg.newFont(14)
  local xpos = math.floor(lg.getWidth() / 2) - math.floor(font:getWidth(score) / 2)
  lg.print(score, font, xpos, 10)

  -- print controls
  local controls = "[SPACE] - launch ball\n[C] / [V] - move paddle up/down"
  xpos = math.floor(lg.getWidth() / 2) - math.floor(font:getWidth(controls) / 2)
  local ypos = math.floor(lg.getHeight() / 2) - math.floor(font:getHeight() / 2)
  if ball.vel == ut.Vec2.new(0, 0) then lg.print(controls, font, xpos, ypos) end

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
