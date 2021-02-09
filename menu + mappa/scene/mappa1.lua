local tiled = require "com.ponywolf.ponytiled"
local json = require "json"

local M = {}

function M.loadLevel(level)
    local mapData = json.decodeFile(system.pathForFile('scene/map/'..level, system.ResourceDirectory))
    return tiled.new(mapData, 'scene/map')
end



return M