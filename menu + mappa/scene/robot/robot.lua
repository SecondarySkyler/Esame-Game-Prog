local M = {}

function M.createRobot()

    --========== CARICO TUTTE LE ANIMAZIONI DEL ROBOT + PROIETTILE ===========================
    local idleData = {width = 57, height = 56, numFrames = 10, sheetContentWidth = 570, sheetContentHeight = 56}
    local idleSheet = graphics.newImageSheet("scene/robot/robotfree/idleSheet.png", idleData)

    local runData = {width = 57, height = 56, numFrames = 8, sheetContentWidth = 456, sheetContentHeight = 56}
    local runSheet = graphics.newImageSheet("scene/robot/robotfree/runSheet.png", runData)

    local deathData = {width = 57, height = 56, numFrames = 10, sheetContentWidth = 570, sheetContentHeight = 56}
    local deathSheet = graphics.newImageSheet("scene/robot/robotfree/deathSheet.png", deathData)

    local jumpData = {width = 57, height = 56, numFrames = 10, sheetContentWidth = 570, sheetContentHeight = 56}
    local jumpSheet = graphics.newImageSheet("scene/robot/robotfree/jumpSheet.png", jumpData)

    local shootData = {width = 57, height = 56, numFrames = 4, sheetContentWidth = 228, sheetContentHeight = 56}
    local shootSheet = graphics.newImageSheet("scene/robot/robotfree/shootSheet.png", shootData)

    local proiettileData = {width = 14, height = 11, numFrames = 5}
    local proiettileSheet = graphics.newImageSheet("scene/robot/robotfree/pro.png", proiettileData)

    local robotSequences = {
        {
            name = "Idle",
            sheet = idleSheet,
            start = 1,
            count = 10,
            time = 800,
            loopCount = 0,
            loopDirection = "forward"
        },
        {
            name = "Run",
            sheet = runSheet,
            start = 1,
            count = 8,
            time = 500,
            loopCount = 0,
            loopDirection = "forward"
        },
        {
            name = "Death",
            sheet = deathSheet,
            start = 1,
            count = 10,
            time = 500,
            loopCount = 1,
            loopDirection = "forward"
        },
        {
            name = "Jump",
            sheet = jumpSheet,
            start = 1,
            count = 10,
            time = 800,
            loopCount = 1,
            loopDirection = "forward"
        },
        {
            name = "Shoot",
            sheet = shootSheet,
            start = 1,
            count = 4,
            time = 500,
            loopCount = 1,
            loopDirection = "forward"
        }
    }

    local proiettileSequences = {
        name = "sparo",
        start = 1,
        count = 5,
        time = 500,
        loopCount = 1,
        loopDirection = "forward"
    }
    --==================== FINE ANIMAZIONI =======================

    local robot = display.newSprite(idleSheet, robotSequences)
    robot:setSequence("Idle")
    robot:play()
    physics.addBody(robot, "dynamic", {bounce = 0,0})
    robot.isFixedRotation = true

    return robot

end

-- FUNZIONE PER IL MOVIMENTO DEL ROBOT
function M.moveRobot(robot, event)
    if (event.phase == "began") then
        robot:setSequence("Run")
        robot:play()
        robot:setLinearVelocity(120, 0)
    elseif (event.phase == "ended") then
        robot:setSequence("Idle")
        robot:play()
        robot:setLinearVelocity(0, 0)
    end
end


-- FUNZIONE PER IL SALTO DEL ROBOT
function M.jumpRobot(robot, event)
    robot:setSequence("Jump")
    robot:play()
    robot:applyLinearImpulse(0, -0.12, robot.x, robot.y)
    
    -- Funzione locale per "ascoltare" quando l'animazione del salto termina e settare la sequenza idle
    local function spriteListener(event)
        if (event.phase == "ended") then
            robot:setSequence("Idle")
            robot:play()
        end
    end

    robot:addEventListener("sprite", spriteListener)
end


function M.shootRobot(robot, event)
    robot:setSequence("Shoot")
    robot:play()

    local proiettile = display.newSprite(proiettileSheet, proiettileSequences)
    proiettile.x = robot.x + 30
    proiettile.y = robot.y - 13
    proiettile:play()
    physics.addBody(proiettile, "kinematic")
    proiettile:setLinearVelocity(200,0)
end

return M