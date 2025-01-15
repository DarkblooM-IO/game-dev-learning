function love.load()
end

function love.update(dt)
end

function love.draw()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "escape" then love.event.quit() end
end
