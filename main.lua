-- this si the mian lua for klapicus city.  for iPad

-- we will start small and expand.

-- first we will draw a grid on the screen.

-- Vars

local cityWidth = 10
local cityHeight = 10
local gridSizeWidth = 19
local gridSizeHeight = 19
local gridSpacingX = 20
local gridSpacingY = 20
local cityGrids = {}

for x=1, cityWidth do
    cityGrids[x] = {}
     for y=1, cityHeight do
         cityGrids[x][y] = {}
         cityGrids[x][y].gridObj = display.newRect(x * gridSpacingX, y* gridSpacingY,gridSizeWidth,gridSizeHeight)
         cityGrids[x][y].realWorld = {x = x * gridSpacingX, y = y* gridSpacingY}

     end
end



