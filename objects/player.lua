require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Camera = require("hump.camera")
local Gameobject = require("objects.gameobject")
local Projectile = require("objects.projectile")
local Ship = require("objects.ship")

local Player = Class{inherits = Ship, function(self, position, size)
    Ship.construct(self, position, size, 10)

    self.weapon2 = require("objects.weapons.exploder")()
end}

function Player:update(dt)
    Ship.update(self, dt)

    local backupcoeff = 1.2
    local strafecoeff = 1.4

    if love.keyboard.isDown("w", "up") then
        local v = vector(0, -self.speed)
        v:rotate_inplace(self.body:getAngle())
        self.body:applyForce(v.x, v.y)
    end
    if love.keyboard.isDown("s", "down") then
        local v = vector(0, self.speed / backupcoeff)
        v:rotate_inplace(self.body:getAngle())
        self.body:applyForce(v.x, v.y)
    end
    if love.keyboard.isDown("a", "left") then
        --local v = vector(-self.speed / strafecoeff, 0)
        --v:rotate_inplace(self.body:getAngle())
        --self.body:applyForce(v.x, v.y)
        self.body:setAngle(self.body:getAngle() + (-3 * dt))
    end
    if love.keyboard.isDown("d", "right") then
        --local v = vector(self.speed / strafecoeff, 0)
        --v:rotate_inplace(self.body:getAngle())
        --self.body:applyForce(v.x, v.y)
        self.body:setAngle(self.body:getAngle() + (3 * dt))
    end

    if love.keyboard.isDown("x", "l") or love.mouse.isDown("l") then
        self:fire(self.weapon)
    end

    if love.keyboard.isDown("z", "p") or love.mouse.isDown("2") then
        self:fire(self.weapon2)
    end

    local mx, my = love.mouse.getPosition()
    mx, my = gameCamera:worldCoords(mx, my)
    local bx, by = self.body:getWorldCenter()
    -- self.body:setAngle(math.atan2(by - my, bx - mx) - (math.pi / 2))
end

function Player:draw()
    love.graphics.setColor(255, 255, 255, 255)
    Ship.draw(self)
end

return Player
