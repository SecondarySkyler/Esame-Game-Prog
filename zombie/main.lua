-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require('physics')
local zombie = require('zombie')
local xeon = require('xeon')
local boss = require('boss')

physics.setDrawMode("hybrid")
physics.start()


--creazione della piattaforma
local platform = display.newRect(0, display.contentHeight - 10, 3840, 20)
local platformFilter = {categoryBits = 1, maskBits = 2}
physics.addBody(platform, "static", {bounce = 0, friction = 0.5})

-- pulsanti temporanei per testare movimento e salto
local button = display.newRect(560,display.contentCenterY,50,50)
local jump = display.newRect(750,display.contentCenterY,50,50)
local shoot = display.newRect(960,display.contentCenterY,50,50)

--creazione dello zombie + movimento + ronda
local enemy = zombie.new()
zombie.initialize(enemy, 950, 200)
zombie.movement(enemy, 130, 900, 1700)

-- creazione personaggio + funzione per movimento + funzione salto
local hero = xeon.new()
xeon.create(hero, 700, display.contentHeight - 100)

local function xeonMove(event)
    xeon.moveXeon(hero, event)
end

local function xeonJump(event)
    xeon.jumpXeon(hero, event)
end

local function xeonShoot(event)
    xeon.shoot(hero, event)
end

-- creazione del boss 
local b = boss.new()
boss.animate(b)
boss.startShoot(b, hero.x, hero.y)


button:addEventListener("touch", xeonMove)
jump:addEventListener("tap", xeonJump)
shoot:addEventListener("tap", xeonShoot)














