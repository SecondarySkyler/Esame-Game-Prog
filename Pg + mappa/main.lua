local physics = require "physics"
local map = require "map"
local robot = require "robot"
local zombie = require 'zombie'


physics.start()
physics.setDrawMode("hybrid")

local level = map.loadMap("testLevel.json")



local character = robot.createRobot()
character.x = display.contentCenterX
character.y = display.contentCenterY 

local enemy1 = zombie.createZombie()
enemy1.x = 400
enemy1.y = display.contentHeight - 50






