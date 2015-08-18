require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Gameobject = require("objects.gameobject")

local Ship = Class{inherits = Gameobject, function(self, position, size, density)
    Gameobject.construct(self, position, size, density)
    self.body:setFixedRotation(true)
    self.body:setLinearDamping(2)
    self.speed = 400
    self.cooldown = 0

    self.damage = 100
    self.maxdamage = 100

    self.color = {255, 255, 255, 255}

    self.weapon = require("objects.weapons.threeshot")()
end}

function Ship:update(dt)
    self.cooldown = self.cooldown - dt
    if self.cooldown < 0 then self.cooldown = 0 end
end

function Ship:projectileHit(projectile)
    self:takeDamage(projectile.damage)
end

function Ship:die()
    self:destroy()
end

function Ship:repair(dmg)
    self.damage = self.damage - dmg
    if self.damage > self.maxdamage then
        self.damage = self.maxdamage
    end
end

function Ship:takeDamage(dmg)
    self.damage = self.damage - dmg
    if self.damage <= 0 then
        self.damage = 0
        self:die()
    end
end

function Ship:fire(weapon)
    weapon = weapon or self.weapon
    if self.cooldown > 0 then return end

    -- table.insert(self.projectiles, 1, projectile)
    weapon:fireFrom(self)
    -- local p = Projectile(self)
end

function Ship:draw()
    love.graphics.setColor(self.color)
    Gameobject.draw(self)

    local x, y = self.body:getWorldCenter()
    local dvec = vector(0, -self.size.y)
    dvec:rotate_inplace(self.body:getAngle())
    love.graphics.line(x, y, x + dvec.x, y + dvec.y)

    local x, y = self.body:getWorldCenter()
    local savg = (self.size.x + self.size.y) / 2
    local hsavg = savg / 2
    local barwidth = 100
    local barheight = 8

    love.graphics.setColor(128, 128, 128, 128)
    love.graphics.rectangle("line", x - (barwidth / 2), y + hsavg + 10, barwidth, barheight) 
    love.graphics.setColor(255 * math.abs((self.damage / self.maxdamage) - 1), (self.damage / self.maxdamage) * 255, 0, 128)
    love.graphics.rectangle("fill", x - (barwidth / 2) + 1, y + 10 + hsavg + 1, (self.damage / self.maxdamage) * (barwidth - 2), barheight - 2)
end

return Ship
