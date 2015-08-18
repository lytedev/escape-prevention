require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Gameobject = require("objects.gameobject")

local Projectile = Class{inherits = Gameobject, function(self, parent, size, offset, velocity, cooldown, damage, angle, fixang, useParentVelocity, color, lifetime, fadetime, density, persists)
    a = a or {}
    a = table.copy(a)
    self.parent = parent
    local size = size or vector(3, 6)
    local useParentVelocity = useParentVelocity or 1
    local fixang = fixang or true
    local offset = offset or vector(0, -24)
    local velocity = velocity or vector(0, -32)
    local angle = angle or 0

    self.cooldown = cooldown or 0.1
    self.damage = damage or 5
    self.fadetime = fadetime or 0.1
    self.lifetime = lifetime or 2
    self.color = color or {255, 40, 0, 255}
    self.persists = persists or false

    Gameobject.construct(self, vector(self.parent.body:getWorldCenter()), size, density or 0.5)

    self.body:setBullet(true)

    self.body:setFixedRotation(fixang)
    local angle = angle + parent.body:getAngle()
    self.body:setAngle(angle)

    offset = offset:rotated(angle)
    velocity = velocity:rotated(angle)

    offset.x = offset.x + self.body:getX()
    offset.y = offset.y + self.body:getY()

    self.body:setPosition(offset.x, offset.y)
    if useParentVelocity then
        local vx, vy = parent.body:getLinearVelocity()
        self.body:setLinearVelocity(vx, vy)
    end
    self.body:applyForce(velocity.x, velocity.y)
end}

function Projectile:update(dt)
    self.lifetime = self.lifetime - dt
    if self.lifetime <= 0 then
        self:destroy()
    end
    if self.lifetime < 0 then self.lifetime = 0 end
end

function Projectile:draw()
    col = {self.color[1], self.color[2], self.color[3], self.color[4]}

    if self.lifetime < self.fadetime then
        col[4] = math.ceil((self.lifetime / self.fadetime) * 255)
    end
    love.graphics.setColor(col)
    Gameobject.draw(self)
end

return Projectile
