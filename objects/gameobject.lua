require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local pairs = pairs

local Gameobject = Class{
    function(self, position, size, density, gotype)
        local gotype = gptype or "dynamic"
        self.size = size
        self.body = love.physics.newBody(world, position.x, position.y, gotype)
        self.shape = love.physics.newRectangleShape(size.x, size.y)
        self.fixture = love.physics.newFixture(self.body, self.shape, density or 1)
        self.fixture:setUserData(self)

        self.id = self.nextGameobjectId()
        table.insert(self.gameobjects, self.id, self)
        --print("Creating Gameobject " .. self.id)
    end
}

Gameobject.gameobjects = {}
Gameobject.gameobjectsToDestroy = {}
Gameobject.lastUsedGameobjectId = 0

function Gameobject.nextGameobjectId()
    Gameobject.lastUsedGameobjectId = Gameobject.lastUsedGameobjectId + 1
    return Gameobject.lastUsedGameobjectId
end

function Gameobject.getFirstAvailableGameobjectId()
    for i = 1, #Gameobject.gameobjects do
        if Gameobject.gameobjects[i] == nil then
            return i
        end
    end
    Gameobject.lastUsedGameobjectId = #Gameobject.gameobjects + 1
    return Gameobject.lastUsedGameobjectId
end

function Gameobject.removeDestroyedObjects()
    for key, val in pairs(Gameobject.gameobjectsToDestroy) do
        local id = val
        local g = Gameobject.gameobjects[id]
        if g then
            g.destroyed = true
            g.body:destroy()
        end
        Gameobject.gameobjects[id] = nil
        --print("Destroying Gameobject " .. id .. "(Key: " .. key .. ")")
    end
    Gameobject.gameobjectsToDestroy = {}
end

function Gameobject:destroy()
    if not self.destroying then
        self.destroying = true
        table.insert(Gameobject.gameobjectsToDestroy, self.id)
    end
    --print("Queueing Destruction of Gameobject " .. self.id)
end

function Gameobject:update(dt)
end

function Gameobject:draw()
end

return Gameobject
