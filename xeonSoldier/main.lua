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

-- character 
local xeon = display.newImage("img/shoot.png", 51, 56)
xeon.x = 40
xeon.y = display.contentHeight - 45
physics.addBody(xeon, "dynamic")

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

local laserCollision = {categoryBits = 1,maskBits = 2}


-- function for shooting
local function shoot(event)
    local laser = display.newSprite(laserSheet, laserSeqs) 
    physics.addBody(laser, "dynamic", {filter = laserCollision})
    laser.x = xeon.x
    laser.y = xeon.y
    laser:play()
    local sh = transition.to(laser, {x = 1080, time = 1200})
end

--enemy
local zombieOpt = {width = 94, height = 79, numFrames = 12}
local zombieSheet = graphics.newImageSheet("img/deathAnim.png", zombieOpt)
local zombieSeqs = {
    name = "zombieDead",
    start = 1,
    count = 12,
    time = 500,
    loopCount = 1,
    loopDirection = "forward"
}

local zombie = display.newSprite(zombieSheet, zombieSeqs)
zombie:scale(-1, 1)
zombie.x = 400
zombie.y = display.contentHeight - 50
life = 100
local isDead = false
local enemyLife = display.newText({text = "HP: "..life, x = zombie.x, y = zombie.y - 30, fontSize = "10"})
local zombieCollision = {categoryBits = 2, maskBits = 1}
--local zombieOutline = graphics.newOutline(1, zombieSheet, 1)
physics.addBody(zombie, "static", {filter = zombieCollision, outline = zombieOutline})

--funzione per rimuovere i corpi morti
local function removeDeadBodies() 
        zombie:removeSelf()
        zombie = nil
        print("dead")
end

-- funzione che gestisce la collisione tra proiettile e nemico
local function shootCollision (event)
    if (event.phase == "began") then
        --testo per l'hitmarker
        local plus = display.newText({text = "10", x = zombie.x, y = zombie.y, fontSize = "20"})
        plus:setFillColor(1,0,0)
        transition.moveBy(plus, {y = -80, alpha = 0})
        --aggiorno la vita del nemico 
        life = life - 10
        enemyLife.text = "HP: "..life
    end
    if (event.phase == "ended") then
        --rimuovo il proiettile dopo la collisione
        event.object2:removeSelf()
        event.object2 = nil
        -- dovrebbe rimuovere il nemico solo se la vita arriva a 0  
        if (life == 0) then
            zombie:play()
            isDead = true
            transition.fadeOut(event.object1, {time = 1000, onComplete = removeDeadBodies})
        end 
    end
end

Runtime:addEventListener("collision", shootCollision)
xeon:addEventListener("tap", shoot)