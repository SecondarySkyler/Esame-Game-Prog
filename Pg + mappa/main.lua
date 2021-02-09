local physics = require "physics"
local map = require "map"
local robot = require "robot"
local vjoy = require "com.ponywolf.vjoy"
local joykey = require("com.ponywolf.joykey").start()

physics.start()
--physics.setDrawMode("hybrid")

local level = map.loadMap("testLevel.json")

local cx, cy = display.contentCenterX, display.contentCenterY - 128
local w, h = display.contentWidth, display.contentHeight

local moveButton = display.newRect(50,50,20,20)
local jumpButton = display.newRect(100,50,20,20)
local shootButton = display.newRect(150,50,20,20)

local leftStick = vjoy.newStick(1,16,30) -- default stick
leftStick.x, leftStick.y = 20, h - 40


local character = robot.createRobot()
character.x = display.contentCenterX
character.y = display.contentCenterY 

local function robotMove(event)
    robot.moveRobot(character, event)
end

local function robotJump(event)
    robot.jumpRobot(character, event)
end

local function robotShoot(event)
    robot.shootRobot(character, event)
end


moveButton:addEventListener("touch", robotMove)
jumpButton:addEventListener("tap", robotJump)
shootButton:addEventListener("tap", robotShoot)





