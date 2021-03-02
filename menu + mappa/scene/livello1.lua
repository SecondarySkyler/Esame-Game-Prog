local composer = require ("composer")
local tiled = require "com.ponywolf.ponytiled"
local json = require "json"
local physics = require ("physics")
local robot = require("scene.robot.robot")

-- Variabili locali per la scena
local map, mapData, hero, background

local scene = composer.newScene()
local sceneGroup


function scene:create(event) 
    sceneGroup = self.view
    
    -- Parte la fisica
    physics.start()

    -- Creazione della mappa
    local filename = 'scene/map/prova.json'
    mapData = json.decodeFile(system.pathForFile(filename, system.ResourceDirectory))
    map = tiled.new(mapData, "scene/map")
   
   
    -- Creazione del robot (eroe)
    hero = robot.createRobot()


    -- Aggiungiamo alla scena gli oggetti, !!! ordine => back-to-front
    sceneGroup:insert(map)
end

function scene:show(event)
    sceneGroup = self.view
    local phase = event.phase

    -- if (phase == 'will') then
    --     background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    --     background.anchorX = 0
    --     background.anchorY = 0
    -- elseif (phase == 'did') then
    --     physics.start()
    -- end
end 

function scene:hide (event) 
    sceneGroup = self.view
    local phase = event.phase

    if (phase == 'will') then
        physics.pause()
    elseif (phase == 'did') then

    end
end

function scene:destroy (event) 
    sceneGroup = self.view
end

scene:addEventListener('create')
scene:addEventListener('show')
scene:addEventListener('hide')
scene:addEventListener('destroy')

return scene


