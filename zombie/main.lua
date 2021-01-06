-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require('physics')
physics.setDrawMode("hybrid")
physics.start()
--physics.setGravity(0, 0)
local platform = display.newRect(0, display.contentHeight - 10, 3840, 20)
physics.addBody(platform, "static", {bounce = 0, friction = 0.5})

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
zombie:scale(1.5, 1.5)
zombie:setSequence("Walk")
zombie:play()
physics.addBody(zombie, "dynamic", {bounce = 0, outline = zombieOutlineDX})
zombie:setLinearVelocity(130,0)
zombie.isFixedRotation = true




-- xeon soldier

--xeon walk sheet
local xeonWalkData = {width = 49, height = 58, numFrames = 10, sheetContentWidth = 490, sheetContentHeight = 58}
local xeonWalkSheet = graphics.newImageSheet("img/xeonWalk.png", xeonWalkData)

--xeon jump sheet
local jumpData = {width = 43, height = 63, numFrames = 12, sheetContentWidth = 516, sheetContentHeight = 63}
local jumpSheet = graphics.newImageSheet("img/jumpSheet.png", jumpData)
local xeonSequences = {
    {
        name = "walk",
        sheet = xeonWalkSheet,
        start = 1,
        count = 10,
        time = 700,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "jump",
        sheet = jumpSheet,
        start = 1,
        count = 12,
        time = 1500,
        loopCount = 1,
        loopDirection = "forward"
    }
}
local xeon = display.newSprite (xeonWalkSheet, xeonSequences)
xeon.x = 200
xeon.y = display.contentHeight - 69
xeon:scale(2,2)
xeon:setSequence("walk")
physics.addBody(xeon, "dynamic", {bounce = 0})
xeon.isFixedRotation = true


-- button for xeon movement
local button = display.newRect(560,display.contentCenterY,50,50)
local jump = display.newRect(750,display.contentCenterY,50,50)




--enemy movement

-- uso queste linee cosi posso verificare che il nemico effettivamente si muove all'interno di esse
local line1 = display.newLine(800,0, 800, display.contentHeight)
line1.strokeWidth = 8
local line2 = display.newLine(1300,0, 1300, display.contentHeight)
line2.strokeWidth = 8

local function ronda(event)
    if (zombie.x >= 1300) then
        zombie:scale(-1, 1)
        zombie:setLinearVelocity(-130, 0)
    elseif (zombie.x <= 800) then
        zombie:scale(-1, 1)
        zombie:setLinearVelocity(130, 0)
    end
end

--xeon move
local function moveXeon(event)
    if (event.phase == "began") then
        xeon:setSequence("walk")
        xeon:play()
        xeon:setLinearVelocity(130, 0)
    elseif(event.phase == "ended") then
        xeon:pause()
        xeon:setLinearVelocity(0,0)
    end
end

--xeon jump
local function jumpXeon(event)
    xeon:setSequence("jump")
    xeon:play()
    xeon:applyLinearImpulse(0, -0.25, xeon.x, xeon.y)
end

Runtime:addEventListener("enterFrame", ronda)
button:addEventListener("touch", moveXeon)
jump:addEventListener("tap", jumpXeon)