-- this si the mian lua for klapicus city.  for iPad

-- we will start small and expand.

-- first we will draw a grid on the screen.

-- Vars

local cityWidth = 10
local cityHeight = 10
local gridSizeWidth = 40
local gridSizeHeight = 40
local gridSpacingX = 41
local gridSpacingY = 41
local cityGrids = {}
local mode = "edit"
local zoomScale = .2
local materials = {}




materials.road = {}
materials.road.color = 100,100,100
materials.road.image = nil


local selectedMaterial = materials.road
-- display groups.

local gridGroup = display.newGroup()
local guiGroup = display.newGroup()

-- displayGroup Functions
 -- grid dragger
local function gridGroupTouch(event)
    if mode == "look" then
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
end

-- onBlock update

local function onUpdate(x,y)

    print(x,y,"updated baby")

end


-- grid changer function

local function gridChanger(x,y,type)
if type == materials.road then
    print("change block",x,y,"to road")
    cityGrids[x][y].gridObj:setFillColor(materials.road.color)
    end
cityGrids[x][y].onUpdate()

end


gridGroup:addEventListener("touch", gridGroupTouch)
 -- darws grid
for x=1, cityWidth do
    cityGrids[x] = {}
     for y=1, cityHeight do
         cityGrids[x][y] = {}
         cityGrids[x][y].gridObj = display.newRect(x * gridSpacingX, y* gridSpacingY,gridSizeWidth,gridSizeHeight)
         cityGrids[x][y].gridObj:setFillColor(0,255,100)
         cityGrids[x][y].onUpdate = function()

         print("updated block")
             onUpdate(x,y)

         end
         -- the event listner for city grids


         cityGrids[x][y].touch = function(event)
             if mode ~= "look" then
                 if mode == "edit" then
                     if event.phase == "ended" then

                         gridChanger(x,y,selectedMaterial)
             print(event.phase,x,y)


                     end
                 end
                 end
         end
         -- end the listener

         cityGrids[x][y].realWorld = {x = x * gridSpacingX, y = y* gridSpacingY }
         cityGrids[x][y].gridObj:addEventListener("touch", cityGrids[x][y].touch)

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

