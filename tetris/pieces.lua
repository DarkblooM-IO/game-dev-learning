local pieces = {}

PIXEL_SIZE = 20

local i = {}
i.color = {0,255,255}
i.states = {
  {
    {0,0,0,0},
    {1,1,1,1},
    {0,0,0,0},
    {0,0,0,0}
  },
  {
    {0,0,1,0},
    {0,0,1,0},
    {0,0,1,0},
    {0,0,1,0}
  },
  {
    {0,0,0,0},
    {0,0,0,0},
    {1,1,1,1},
    {0,0,0,0}
  },
  {
    {0,1,0,0},
    {0,1,0,0},
    {0,1,0,0},
    {0,1,0,0}
  },
}

local j = {}
j.color = {0,0,255}
j.states = {
  {
    {1,0,0},
    {1,1,1},
    {0,0,0}
  },
  {
    {0,1,1},
    {0,1,0},
    {0,1,0}
  },
  {
    {0,0,0},
    {1,1,1},
    {0,0,1}
  },
  {
    {0,1,0},
    {0,1,0},
    {1,1,0}
  }
}

local l = {}
l.color = {255,170,0}
l.states = {
  {
    {0,0,1},
    {1,1,1},
    {0,0,0}
  },
  {
    {0,1,0},
    {0,1,0},
    {0,1,1}
  },
  {
    {0,0,0},
    {1,1,1},
    {1,0,0}
  },
  {
    {1,1,0},
    {0,1,0},
    {0,1,0}
  }
}

local o = {}
o.color = {255,255,0}
o.states = {
  {
    {1,1},
    {1,1}
  }
}

local s = {}
s.color = {0,255,0}
s.states = {
  {
    {0,1,1},
    {1,1,0},
    {0,0,0}
  },
  {
    {0,1,0},
    {0,1,1},
    {0,0,1}
  },
  {
    {0,0,0},
    {0,1,1},
    {1,1,0}
  },
  {
    {1,0,0},
    {1,1,0},
    {0,1,0}
  }
}

local t = {}
t.color = {153,0,255}
t.states = {
  {
    {0,1,0},
    {1,1,1},
    {0,0,0}
  },
  {
    {0,1,0},
    {0,1,1},
    {0,1,0}
  },
  {
    {0,0,0},
    {1,1,1},
    {0,1,0}
  },
  {
    {0,1,0},
    {1,1,0},
    {0,1,0}
  }
}

local z = {}
z.color = {255,0,0}
z.states = {
  {
    {1,1,0},
    {0,1,1},
    {0,0,0}
  },
  {
    {0,0,1},
    {0,1,1},
    {0,1,0}
  },
  {
    {0,0,0},
    {1,1,0},
    {0,1,1}
  },
  {
    {0,1,0},
    {1,1,0},
    {1,0,0}
  }
}

pieces.tetrominos = {i, j, l, o, s, t, z}

pieces.drawPiece = function (piece, state, x, y)
  for py = 1, #piece.states[state] do
    for px = 1, #piece.states[state][py] do
      if piece.states[state][py][px] == 1 then
        lg.setColor(love.math.colorFromBytes(piece.color))
        lg.rectangle("fill", x + (px * PIXEL_SIZE - PIXEL_SIZE), y + (py * PIXEL_SIZE - PIXEL_SIZE), PIXEL_SIZE, PIXEL_SIZE)
        lg.setColor(0,0,0)
        lg.rectangle("line", x + (px * PIXEL_SIZE - PIXEL_SIZE), y + (py * PIXEL_SIZE - PIXEL_SIZE), PIXEL_SIZE, PIXEL_SIZE)
      end
    end
  end
end

return pieces
