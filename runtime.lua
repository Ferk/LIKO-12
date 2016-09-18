local r = {}

function r.newGlobals()
  local GLOB = {
    assert=assert,
    error=error,
    ipairs=ipairs,
    pairs=pairs,
    next=next,
    pcall=pcall,
    select=select,
    tonumber=tonumber,
    tostring=tostring,
    type=type,
    unpack=unpack,
    _VERSION=_VERSION,
    xpcall=xpcall,
    string={
      byte=string.byte,
      char=string.char,
      find=string.find,
      format=string.format,
      gmatch=string.gmatch,
      gsub=string.gsub,
      len=string.len,
      lower=string.lower,
      match=string.match,
      rep=string.rep,
      reverse=string.reverse,
      sub=string.sub,
      upper=string.upper
    },
    table={
      insert=table.insert,
      maxn=table.maxn,
      remove=table.remove,
      sort=table.sort
    },
    math={
      abs=math.abs,
      acos=math.acos,
      asin=math.asin,
      atan=math.atan,
      atan2=math.atan2,
      ceil=math.ceil,
      cos=math.cos,
      cosh=math.cosh,
      deg=math.deg,
      exp=math.exp,
      floor=math.floor,
      fmod=math.fmod,
      frexp=math.frexp,
      huge=math.huge,
      ldexp=math.ldexp,
      log=math.log,
      log10=math.log10,
      max=math.max,
      min=math.min,
      modf=math.modf,
      pi=math.pi,
      pow=math.pow,
      rad=math.rad,
      random=math.random,
      randomseed=math.randomseed,
      sin=math.sin,
      sinh=math.sinh,
      sqrt=math.sqrt,
      tan=math.tan,
      tanh=math.tanh,
    },
    --API SECTION--
    --Callbacks--
    --[[_startup=function() end,
    _update=function() end,
    _mpress=function() end,
    _mmove=function() end,
    _mrelease=function() end,
    _tpress=function() end,
    _tmove=function() end,
    _trelease=function() end,
    _kpress=function() end,
    _krelease=function() end,
    _tinput=function() end,]]
    --Graphics--
    clear=clear,
    color=color,
    stroke=stroke,
    points=points,
    point=point,
    line=line,
    circle=circle,
    circle_line=circle_line,
    rect=rect,
    rect_line=rect_line,
    print=print,
    print_grid=print_grid,
    --Sprites--
    Image=Image,
    ImageData=ImageData,
    SpriteSheet=SpriteSheet,
    Sprite=Sprite,
    SpriteGroup=SpriteGroup,
    --Cursors--
    newCursor=newCursor,
    setCursor=setCursor,
    --Math--
    ostime=ostime,
    rand=rand,
    rand_seed=rand_seed,
    floor=floor,
    --GUI--
    isInRect=isInRect,
    whereInGrid=whereInGrid,
    keyrepeat=keyrepeat,
    showkeyboard=showkeyboard,
    --Must change--
    SpriteMap=SpriteMap
  }
  GLOB._G=GLOB --Mirror Mirror
  return GLOB
end

local function tr(fnc,...)
  if not fnc then return end
  local ok, err = pcall(fnc,...)
  if not ok then
    r.onerr(err)
    r.cg = {}
  end
end

function r:compile(code, G, spritesheet)
  local G = G or r.newGlobals()
  local chunk, err = loadstring(code or "")
  if(err and not chunk) then -- maybe it's an expression, not a statement
    chunk, err = loadstring("return " .. code)
    if(err and not chunk) then
      return false, err
    end
  end

  setfenv(chunk,G)
  G.SpriteMap = spritesheet
  self.cg = G
  return chunk
end

function r:loadGame(code,spritesheet,onerr)
  local success, err = pcall(assert(r:compile(code, nil, spritesheet)))
  if not success then return false, err end
  self.onerr = onerr or error
  return true
end

function r:startGame()
  clear(1)
  tr(self.cg._startup)
end

function r:_startup()
  self.cg = {}
end

function r:_update(...)
  tr(self.cg._update,...)
end

function r:_mpress(...)
  tr(self.cg._mpress,...)
end

function r:_mmove(...)
  tr(self.cg._mmove,...)
end

function r:_mrelease(...)
  tr(self.cg._mrelease,...)
end

function r:_tpress(...)
  tr(self.cg._tpress,...)
end

function r:_tmove(...)
  tr(self.cg._tmove,...)
end

function r:_trelease(...)
  tr(self.cg._trelease,...)
end

function r:_kpress(...)
  tr(self.cg._kpress,...)
end

function r:_krelease(...)
  tr(self.cg._krelease,...)
end

function r:_tinput(...)
  tr(self.cg._tinput,...)
end

return r