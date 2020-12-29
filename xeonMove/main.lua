-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require('physics')
physics.setDrawMode("hybrid")
physics.start()
local platform = display.newRect(0, display.contentHeight - 10, 1080, 20)
physics.addBody(platform, "static")

--======================== CARICO LO SPRITESHEET PER OGNI SINGOLA ANIMAZIONE=======================
--sprite sheet
local deathData = {width = 88, height = 90, numFrames = 10, sheetContentWidth = 880, sheetContentHeight = 90}
local deathSheet = graphics.newImageSheet("img/deathAnim.png", deathData)

--run
local runData = {width = 62, height = 76, numFrames = 10, sheetContentWidth = 620, sheetContentHeight = 76}
local runSheet = graphics.newImageSheet("img/runAnimation.png", runData)

--jump
local jumpData = {width = 61, height = 80, numFrames = 10, sheetContentWidth = 610, sheetContentHeight = 80}
local jumpSheet = graphics.newImageSheet("img/jumpAnimation.png", jumpData)
--idle
local idleData = {width = 48, height = 73, numFrames = 10, sheetContentWidth = 480, sheetContentHeight = 73}
local idleSheet = graphics.newImageSheet("img/idleAnimation.png", idleData)

local options = {width = 88, height = 88, numFrames = 50}
local boySheet = graphics.newImageSheet("img/cowboySprite.png", options)
local boySeqs = {
    {
        name = "Death",
        sheet = deathSheet,
        start = 1,
        count = 10,
        time = 500,
        loopCount = 1   
    },
    {
        name = "Idle",
        sheet = idleSheet,
        start = 1,
        count = 10,
        time = 500,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "Jump",
        sheet = jumpSheet,
        start = 1,
        count = 10,
        time = 500,
        loopCount = 1,
        loopDirection = "forward"
    },
    {
        name = "Run",
        sheet = runSheet,
        start = 1,
        count = 10,
        time = 500,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "Slide",
        start = 41,
        count = 50,
        time = 500,
        loopCount = 0,
        loopDirection = "forward"
    }
}


--creo il personaggio, lo setto in idle, lo aggiungo al mondo fisico
local cowboy = display.newSprite(boySheet, boySeqs)
cowboy.x = 75
cowboy.y = display.contentHeight - 30
cowboy:setSequence("Idle")
local isOnTheFloor = true
physics.addBody(cowboy, "dynamic")

--button for movement
local buttonRight = display.newRect (display.contentWidth - 50, display.contentHeight - 150, 20, 20)
buttonRight.name = "right"
local buttonLeft = display.newRect (50, display.contentHeight - 150, 20, 20)
buttonLeft.name = "left"
local button = display.newRect (150, display.contentHeight - 150, 20, 20)
button.name = "die"
local jump = display.newRect (300, display.contentHeight - 150, 20, 20)
jump.name = "left"

--function for movement
local function cowboyMove(event) 
    local direction = event.target

    if (event.phase == "began") then
        if (direction.name == "right") then
            cowboy:setSequence("Run")
            cowboy:play()
            cowboy:setLinearVelocity(200, 0)

        elseif (direction.name == "left") then
            cowboy:setSequence("Run")
            cowboy:play()
            cowboy:setLinearVelocity(-200, 0)
        end
    
    elseif (event.phase == "ended") then
        cowboy:setSequence("Idle")
        cowboy:pause()
        cowboy:setLinearVelocity(0,0)
    end
    return true
end

--die
local function dieSeqs(event) 
    cowboy:setSequence("Death")
    cowboy:play()
end

--jump
local function jumpanim(event)
    cowboy.isFixedRotation = true
    cowboy:setSequence("Jump")
    cowboy:play()
    isOnTheFloor = false
    cowboy:applyLinearImpulse(0, -0.2)
end



--listeners
buttonRight:addEventListener("touch", cowboyMove)
buttonLeft:addEventListener("touch", cowboyMove)
button:addEventListener("tap", dieSeqs)
jump:addEventListener("tap", jumpanim)