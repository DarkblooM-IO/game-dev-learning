local Piece = {}
Piece.__index = Piece

function Piece.new(shape, r, g, b)
  local self = setmetatable({}, Piece)

  self.shape = shape
  self.r = r
  self.g = g
  self.b = b
  self.display = lg.newCanvas(#shape[1] * PIXEL_SIZE, #shape * PIXEL_SIZE)

  return self
end

function Piece:draw(canvas)
  lg.setCanvas(self.display)
  lg.setColor(love.math.colorFromBytes(self.r, self.g, self.b))
  for y = 1, #self.shape do
    for x = 1, #self.shape[y] do
      if self.shape[y][x] == 1 then
        lg.rectangle("fill", x * PIXEL_SIZE - PIXEL_SIZE, y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
      end
    end
  end
  lg.setCanvas(canvas)
  lg.draw(self.display, 0, 0)
end

_G.Piece = Piece
