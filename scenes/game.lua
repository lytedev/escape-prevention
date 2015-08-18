require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")
local Gamestate = require("hump.gamestate")

local Camera = require("hump.camera")
local Gameobject = require("objects.gameobject")
local Ship = require("objects.ship")
local Projectile = require("objects.projectile")
local Player = require("objects.player")

local Game = Gamestate.new()

function Game:init()
    self:restart()

    assetManager:loadFont("pf_tempesta_seven_condensed", 8, "px8")
end

function Game:restart()
    love.physics.setMeter(64)
    local gravity = -9.81*love.physics.getMeter()
    local gravity = 0
    world = love.physics.newWorld(0, gravity, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    for k, v in pairs(Gameobject.gameobjects) do
        v:destroy()
    end
    Gameobject.removeDestroyedObjects()
    Gameobject.lastUsedGameobjectId = 0

    self.walls = {}
    self.levelsize = 3000
    self.walls[1] = Gameobject(vector(-self.levelsize, -self.levelsize), vector(self.levelsize, self.levelsize), 10, "static")
    self.walls[2] = Gameobject(vector(0, -self.levelsize), vector(self.levelsize, self.levelsize), 10, "static")
    self.walls[3] = Gameobject(vector(self.levelsize, -self.levelsize), vector(self.levelsize, self.levelsize), 10, "static")
    self.walls[4] = Gameobject(vector(-self.levelsize, 0), vector(self.levelsize, self.levelsize), 10, "static")
    self.walls[6] = Gameobject(vector(self.levelsize, 0), vector(self.levelsize, self.levelsize), 10, "static")
    self.walls[7] = Gameobject(vector(-self.levelsize, self.levelsize), vector(self.levelsize, self.levelsize), 10, "static")
    self.walls[8] = Gameobject(vector(0, self.levelsize), vector(self.levelsize, self.levelsize), 10, "static")
    self.walls[9] = Gameobject(vector(self.levelsize, self.levelsize), vector(self.levelsize, self.levelsize), 10, "static")

    self.walls[10] = Gameobject(vector(10, 10), vector(10, 100), 10000, "static")
    for k,v in pairs(self.walls) do
        v.draw = function(self)
            love.graphics.setColor(0, 0, 0, 255)
            love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
            love.graphics.setLineWidth(3)
            love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
            love.graphics.setLineWidth(1)
        end
    end



    self.camera = Camera(100, 100, 1, 0)
    gameCamera = self.camera
    self.player = Player(vector(100, 100), vector(16, 16))

    self.enemyships = {}

    self:addEnemyShip(vector(200, 200))
end

function Game:addEnemyShip(pos)
    local es = Ship(pos, vector(32, 32))
    es.color = {255, 40, 0, 255}
    es.maxdamage = 20
    es.damage = es.maxdamage
    es.weapon = require("objects.weapons.crapshooter")()
    local randForce = 4000
    -- es.body:applyForce(math.random(randForce) - (randForce / 2), math.random(randForce) - (randForce / 2))
    self.enemyships[es.id] = es
end

function Game:update(dt)
    if math.random() < 0.04 then
        self:addEnemyShip(vector(math.random(self.levelsize) - (self.levelsize / 2), math.random(self.levelsize) - (self.levelsize / 2)))
    end

    self.camera:lookAt(self.player.body:getWorldCenter())
    for k, v in pairs(self.enemyships) do
        if v.destroyed then
            self.enemyships[k] = nil
        else
            local bd = v.body
            local x, y = bd:getWorldCenter()
            local plx, ply = self.player.body:getWorldCenter()
            local angle = math.atan2(y - ply, x - plx) - (math.pi / 2)
            bd:setAngle(angle)
            local force = vector(0, -100)
            force:rotate_inplace(angle)
            bd:applyForce(force.x, force.y)
            if math.random() < 0.05 then
                v:fire()
            end
        end
    end
    Gameobject.removeDestroyedObjects()
    if self.player.destroyed then
        self:restart()
    end
    world:update(dt)
    for key, val in pairs(Gameobject.gameobjects) do
        local g = val
        g:update(dt)
    end
end

function beginContact(a, b, coll)
    local au = a:getUserData()
    local bu = b:getUserData()

    if au:is_a(Projectile) and bu:is_a(Projectile) then
        if au.parent == bu.parent then

        end
    else
        if bu:is_a(Projectile) then
            if au:is_a(Ship) and bu.parent ~= au then
                au:projectileHit(bu)
                if bu.persists then return end
            end
            bu:destroy()
        end
        if au:is_a(Projectile) then
            if bu:is_a(Ship) and au.parent ~= bu then
                bu:projectileHit(au)
                if au.persists then return end
            end
            if not au.persists then
                au:destroy()
            end
        end
    end
end

function endContact(a, b, coll)

end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end

function Game:keypressed(key)
    if key == "escape" then
        Gamestate.switch(require("scenes.mainmenu"))
        -- love.event.quit()
    end
    if key == "r" then
        self:restart()
    end
end

function Game:draw()
    self.camera:attach()
    for key, val in pairs(Gameobject.gameobjects) do
        local g = val
        g:draw(dt)
    end
    self.camera:detach()
    love.graphics.setColor(128, 128, 128, 255)
    love.graphics.setFont(assetManager:getFont("px8"))
    love.graphics.print(Gameobject.lastUsedGameobjectId, 5, 5)
end

return Game
