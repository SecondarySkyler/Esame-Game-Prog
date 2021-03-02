local composer = require "composer"
local tiled = require "com.ponywolf.ponytiled"
local physics = require "physics"
local json = require "json"

local map

local scene = composer.newScene()

function scene:create( event )

	local sceneGroup = self.view
    physics.start()

    local filename = 'scene/mappe/mappa1/mappa1.json'
    local mapData = json.decodeFile(system.pathForFile(filename, system.ResourceDirectory))
    map = tiled.new(mapData, 'scene/mappe/mappa1')

    map.anchorX = 0
    map.anchorY = 0


    sceneGroup:insert(map)
end

scene:addEventListener('create')

return scene