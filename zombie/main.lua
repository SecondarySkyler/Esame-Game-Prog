-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require('physics')
physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0, 0)
local platform = display.newRect(0, display.contentHeight - 10, 1080, 20)
physics.addBody(platform, "static")

-- idle sheet
local idleData = {width = 65, height = 78, numFrames = 15, sheetContentWidth = 975, sheetContentHeight = 78}
local idleSheet = graphics.newImageSheet("img/IdleSheet.png", idleData)
local zombieOutlineDX = graphics.newOutline(1, idleSheet, 1)

-- walk sheet
local walkData = {width = 65, height = 78, numFrames = 10, sheetContentWidth = 650, sheetContentHeight = 78}
local walkSheet = graphics.newImageSheet("img/walkSheet.png", walkData)

local walkDataSX = {width = 65, height = 78, numFrames = 10, sheetContentWidth = 650, sheetContentHeight = 78}
local walkSheetSX = graphics.newImageSheet("img/walkSheetSX.png", walkDataSX)
local zombieWalkOutlineSX = graphics.newOutline(1, walkSheetSX, 1)

local zombieSeqs = {
    {
        name = "Idle",
        sheet = idleSheet,
        start = 1,
        count = 15,
        time = 1500,
        loopCount = 0,
        loopDirection = "bounce"
    },
    {
        name = "Walk",
        sheet = walkSheet,
        start = 1,
        count = 10,
        time = 500,
        loopCount = 0,
        loopDirection = "forward"
    }

} 

local zombie = display.newSprite(idleSheet, zombieSeqs)
zombie.x = display.contentCenterX
zombie.y = display.contentHeight - 58
zombie:setSequence("Walk")
zombie:play()
physics.addBody(zombie, "dynamic", {outline = zombieOutlineDX})
zombie:setLinearVelocity(130, 0)


local function ronda(event)
    if (zombie.x >= 400) then
        zombie:scale(-1, 1)
        zombie:setLinearVelocity(-130, 0)
    elseif (zombie.x <= 20) then
        zombie:scale(-1, 1)
        zombie:setLinearVelocity(130, 0)
    end
end


Runtime:addEventListener("enterFrame", ronda)