require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Gamestate = require("hump.gamestate")
local AssetManager = require("assets.assetmanager")
local Timer = require("hump.timer")

assetManager = AssetManager()
lastMousePosition = vector(0, 0)
world = nil

function love.load()
    print(string.format("\"%s\" %s by %s\n%s", conf.title, conf.titleVersion, conf.author, conf.url))
    love.graphics.setBackgroundColor(17, 17, 17, 255)

    Gamestate.registerEvents()
    local mainmenu = require("scenes.mainmenu")
    Gamestate.switch(mainmenu)

    updateLastMousePosition()
end

function love.update(dt)
    Timer.update(dt)
    updateLastMousePosition()
end

function love.draw()
    love.graphics.clear()
end

function updateLastMousePosition()
    local lastMouseX, lastMouseY = love.mouse.getPosition()
    lastMousePosition = { x = lastMouseX, y = lastMouseY }
end
