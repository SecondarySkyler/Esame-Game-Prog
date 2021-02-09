local tiled = require "com.ponywolf.ponytiled"
local json = require "json"

local M = {}

function M.loadMap(level)
    local mapData = json.decodeFile(system.pathForFile("maps/"..level, system.ResourceDirectory))
    return tiled.new(mapData, "maps")
end

return M

