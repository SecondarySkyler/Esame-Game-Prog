local composer = require 'composer'
local scene = composer.newScene()


local playBtn

local function onPlayButtonRelease(event)
    composer.gotoScene("scene.livello1")
end



function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX
	background.y = 0 + display.screenOriginY
    background:setFillColor(0)


    playBtn = display.newRect(display.contentWidth / 2, display.contentWidth / 2, 50, 50)
    playBtn:setFillColor(1)
    playBtn:addEventListener('tap', onPlayButtonRelease)
    
    
    sceneGroup:insert(background)
    sceneGroup:insert(playBtn)
end

function scene:show(event) 
    local sceneGroup = self.view
end


function scene:destroy(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (playBtn) then 
        composer.removeScene('menu', true)
        playBtn:removeSelf()
        playBtn = nil
    end
end


scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("destroy")

return scene