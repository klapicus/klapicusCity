-- this si the mian lua for klapicus city.  for iPad

-- we will start small and expand.

-- first we will draw a grid on the screen.

-- Vars

local cityWidth = 100
local cityHeight = 100
local gridSizeWidth = 9
local gridSizeHeight = 9
local gridSpacingX = 10
local gridSpacingY = 10
local cityGrids = {}
local mode = "look"
local zoomScale = .2

-- display groups.

local gridGroup = display.newGroup()
local guiGroup = display.newGroup()

-- displayGroup Functions

local function gridGroupTouch(event)
    local self = gridGroup
    if event.phase == "began" then

        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object

    elseif event.phase == "moved" then

        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY

        self.x, self.y = x, y    -- move object based on calculations above
    end

    return true

end


gridGroup:addEventListener("touch", gridGroupTouch)
 -- darws grid
for x=1, cityWidth do
    cityGrids[x] = {}
     for y=1, cityHeight do
         cityGrids[x][y] = {}
         cityGrids[x][y].gridObj = display.newRect(x * gridSpacingX, y* gridSpacingY,gridSizeWidth,gridSizeHeight)

         -- the event listner

         cityGrids[x][y].touch = function(event)

             print(event.phase,x,y)


         end
         -- end the listener

         cityGrids[x][y].realWorld = {x = x * gridSpacingX, y = y* gridSpacingY }
         cityGrids[x][y].gridObj:addEventListener("touch", cityGrids[x][y].touch)
         cityGrids[x][y].gridObj:setFillColor(math.random(0,255),math.random(0,255),math.random(0,255))
         gridGroup:insert(cityGrids[x][y].gridObj)

     end
end

gridGroup.x = 0
gridGroup.y = 200

-- this makes the GUI buttons

local zoomInCity = display.newCircle(20,40,20)
zoomInCity:setFillColor(255,0,10)
zoomInCity.tap = function(event)
    print("In", gridGroup.xScale, gridGroup.yScale)
    gridGroup.xScale = gridGroup.xScale + zoomScale
    gridGroup.yScale = gridGroup.yScale + zoomScale
end
local zoomOutCity = display.newCircle(20,80,20)
zoomOutCity:setFillColor(10,255,10)
zoomOutCity.tap = function(event)
    print("Out", gridGroup.xScale, gridGroup.yScale)
    gridGroup.xScale = gridGroup.xScale - zoomScale
    gridGroup.yScale = gridGroup.yScale - zoomScale
end

zoomOutCity:addEventListener("tap", zoomOutCity)
zoomInCity:addEventListener("tap", zoomInCity)
guiGroup:insert(zoomInCity)
guiGroup:insert(zoomOutCity)

