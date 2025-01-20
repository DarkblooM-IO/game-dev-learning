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
  for y = 1, #self.shape do
    for x = 1, #self.shape[y] do
      if self.shape[y][x] == 1 then
        lg.setColor(love.math.colorFromBytes(self.r, self.g, self.b))
        lg.rectangle("fill", x * PIXEL_SIZE - PIXEL_SIZE, y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
        lg.setColor(0, 0, 0)
        lg.rectangle("line", x * PIXEL_SIZE - PIXEL_SIZE, y * PIXEL_SIZE - PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE)
      end
    end
  end
  lg.setCanvas(canvas)
  lg.setColor(1, 1, 1)
  lg.draw(self.display, 0, 0)
end

TETROMINOS = {
  Piece.new({{1,1},{1,1}},     254,248,76),  -- O
  Piece.new({{1,1,1,1}},       81, 225,253), -- I
  Piece.new({{0,1,1},{1,1,0}}, 233,61, 30),  -- S
  Piece.new({{1,1,0},{0,1,1}}, 106,152,53),  -- Z
  Piece.new({{0,0,1},{1,1,1}}, 246,146,48),  -- L
  Piece.new({{1,0,0},{1,1,1}}, 241,110,185), -- J
  Piece.new({{0,1,0},{1,1,1}}, 148,54, 146)  -- T
}

_G.Piece = Piece
