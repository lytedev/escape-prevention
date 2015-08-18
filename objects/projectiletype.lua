require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local Projectile = require("objects.projectile")

local ProjectileType = Class{function(self, size, offset, velocity, cooldown, damage, angle, fixang, useParentVelocity, color, lifetime, fadetime, density, persists)
    self.size = size
    self.offset = offset
    self.velocity = velocity
    self.cooldown = cooldown
    self.damage = damage
    self.angle = angle
    self.fixang = fixang
    self.useParentVelocity = useParentVelocity
    self.color = color
    self.lifetime = lifetime
    self.fadetime = fadetime
    self.density = density
    self.persists = persists
end}

function ProjectileType:fireFrom(ship) 
    return Projectile(ship, 
            self.size,
            self.offset,
            self.velocity,
            self.cooldown,
            self.damage,
            self.angle,
            self.fixang,
            self.useParentVelocity,
            self.color,
            self.lifetime,
            self.fadetime,
            self.density,
            self.persists
        )
end

return ProjectileType
