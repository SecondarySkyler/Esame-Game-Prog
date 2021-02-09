local M = {}

function M.new()
    -- xeon walk sheet
    local xeonWalkData = {width = 49, height = 58, numFrames = 10, sheetContentWidth = 490, sheetContentHeight = 58}
    local xeonWalkSheet = graphics.newImageSheet("img/xeonWalk.png", xeonWalkData)

    -- xeon jump sheet
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
    local xeonFilterCollision = {categoryBits = 2, maskBits = 4}
    physics.addBody(xeon, "dynamic", {bounce = 0, filter = xeonFilterCollision})
    xeon.isFixedRotation = true
    xeon.name = "xeon"

    --======================= COLLISIONI ====================================
    local function onCollision(self, event)
        local collidedObject = event.other

        if (event.phase == "began") then
            if (collidedObject.name == "minicovid") then
                print("youre dead")
            end
        elseif(event.phase == "ended") then
            display.remove(collidedObject)
        end
    end


    xeon.collision = onCollision

    return xeon
end

--xeon move
function M.moveXeon(xeon, event)
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
function M.jumpXeon(xeon, event)
    xeon:setSequence("jump")
    xeon:play()
    xeon:applyLinearImpulse(0, -0.25, xeon.x, xeon.y)
end

function M.create(xeon, xPos, yPos)
    xeon.x = xPos
    xeon.y = yPos
    xeon:scale(2,2)
    xeon:setSequence("walk")
    xeon:addEventListener("collision", xeon)
end

--definizione dello sprite per il proiettile
local opt = {width = 16, height = 12, numFrames = 5}
local laserSheet = graphics.newImageSheet("img/laser.png", opt)
local laserSeqs = {
    name = "laser",
    start = 1,
    count = 5,
    time = 400,
    loopCount = 0,
    loopDirection = "forward"
}


function M.shoot(xeon, event)
    local laser = display.newSprite(laserSheet, laserSeqs) 
    physics.addBody(laser, "kinematic")
    laser.x = xeon.x
    laser.y = xeon.y
    laser:play()
    local sh = transition.to(laser, {x = 2000, time = 1700})
end



return M