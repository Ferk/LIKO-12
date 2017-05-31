--The default configuation
--per ,err = P(peripheral,mountedName,configTable)

--Create a new cpu mounted as "CPU"
local CPU, CPUKit = assert(P("CPU"))

--Create a new gpu mounted as "GPU"
local GPU, GPUKit = assert(P("GPU","GPU",{
  --_LIKO_W = 8*48, --384
  --_LIKO_H = 8*32, --256
  _ClearOnRender = true,
  CPUKit = CPUKit,
  _ColorSet = {
    {0x00,0x00,0x00,255}, --1
    {0x00,0x00,0xAA,255}, --3
    {0xAA,0x00,0x00,255}, --9
    {0x00,0xAA,0x00,255}, --5
    {0xAA,0x55,0x00,255}, --13
    {0x55,0x55,0x55,255}, --2
    {0xAA,0xAA,0xAA,255}, --15
    {0xFF,0xFF,0xFF,255},  --16
    {0xFF,0x55,0x55,255}, --10
    {0xFF,0xFF,0x55,255}, --14
    {0xAA,0x00,0xAA,255}, --11
    {0x55,0xFF,0x55,255}, --6
    {0x55,0x55,0xFF,255}, --4
    {0x00,0xAA,0xAA,255}, --7
    {0xFF,0x55,0xFF,255}, --12
    {0x55,0xFF,0xFF,255}  --8
    
    --[[
    {0x00,0x00,0x00,255},
    {0x55,0x55,0x55,255},
    {0x00,0x00,0xAA,255},
    {0x55,0x55,0xFF,255},
    {0x00,0xAA,0x00,255},
    {0x55,0xFF,0x55,255},
    {0x00,0xAA,0xAA,255},
    {0x55,0xFF,0xFF,255},
    {0xAA,0x00,0x00,255},
    {0xFF,0x55,0x55,255},
    {0xAA,0x00,0xAA,255},
    {0xFF,0x55,0xFF,255},
    {0xAA,0x55,0x00,255},
    {0xFF,0xFF,0x55,255},
    {0xAA,0xAA,0xAA,255},
    {0xFF,0xFF,0xFF,255}
    ]]
  }
}))
local VRAMHandler = GPUKit.VRAMHandler

--Create a new keyboard api mounted as "KB"
assert(P("Keyboard","Keyboard",{CPUKit = CPUKit, GPUKit = GPUKit,_Android = (_OS == "Android"),_EXKB = true}))

--Create a new virtual hdd system mounted as "HDD"
assert(P("HDD","HDD",{
  C = 1024*1024 * 25, --Measured in bytes, equals 25 megabytes
  D = 1024*1024 * 25 --Measured in bytes, equals 25 megabytes
}))

assert(P("Floppy"))

local KB = function(v) return v*1024 end

local RAMConfig = {
  layout = {
    {736},    --0x0000 Meta Data (736 Bytes)
    {KB(12)}, --0x02E0 SpriteMap (12 KB)
    {288},    --0x32E0 Flags Data (288 Bytes)
    {KB(18)}, --0x3400 MapData (18 KB)
    {KB(13)}, --0x7C00 Sound Tracks (13 KB)
    {KB(20)}, --0xB000 Compressed Lua Code (20 KB)
    {KB(02)}, --0x10000 Persistant Data (2 KB)
    {128},    --0x10800 GPIO (128 Bytes)
    {768},    --0x10880 Reserved (768 Bytes)
    {64},     --0x10B80 Draw State (64 Bytes)
    {64},     --0x10BC0 Reserved (64 Bytes)
    {KB(01)}, --0x10C00 Free Space (1 KB)
    {KB(04)}, --0x11000 Reserved (4 KB)
    {KB(12)}, --0x12000 Label Image (12 KBytes)
    {KB(12),VRAMHandler}  --0x15000 VRAM (12 KBytes)
  }
}

local RAM, RAMKit = assert(P("RAM","RAM",RAMConfig))