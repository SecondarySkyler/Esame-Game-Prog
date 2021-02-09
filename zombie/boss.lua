local M = {}


function M.new() 
    local covid = display.newCircle(1600, 400, 100)

    
            

    return covid
end

function M.animate(covid)
    local newX = math.random(20, 1900)
    local newY = math.random(20, 1060)
    transition.to(covid, {time = 2000, x = newX, y = newY, onComplete = M.animate})
end


function M.startShoot(covid, heroXpos, heroYpos)
    local miniCovid = display.newCircle(covid.x, covid.y, 20)
    miniCovid.name = "minicovid"
    local miniCovidFilterCollision = {categoryBits = 4, maskBits = 2}
    physics.addBody(miniCovid, "kinematic", {filter = miniCovidFilterCollision})
    transition.to(miniCovid, {time = 2000, x = heroXpos, y = heroYpos, onComplete = M.startShoot})
end

return M